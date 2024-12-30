extends Node3D
class_name CamaraControl

@export var max_theta: float = 75
@export var min_theta: float = -90
@export var aceleracion_rotacion: float = 10
@export var sensibilidad: float = 0.1
@export var velocidad_zoom: float = 10
@export var salto_zoom: float = 0.3
@export var distancia_minima: float = 1.5
@export var distancia_maxima: float = 4
@export var distancia_inicial: float = 3
@export var clipear_camara: bool = true;

@onready var clip = $Horizontal/Vertical/Clip
@onready var mira = $Horizontal/Vertical/Camera3D/Mira
@onready var horizontal = $Horizontal
@onready var vertical = $Horizontal/Vertical
@onready var camara = $Horizontal/Vertical/Camera3D

@onready var controles = get_node("/root/InputController")
var _rot_h: float = 0
var _rot_v: float = 0
var _distancia: float = distancia_inicial
var disparando: bool = false

func _ready():
	if _distancia < distancia_minima:
		_distancia = distancia_minima
	clip.target_position.z = _distancia

func _input(event):
	if controles.capturando:
		if event is InputEventMouseMotion:
			_rot_h -= controles.mouse_posicion.x * sensibilidad
			_rot_v -= controles.mouse_posicion.y * sensibilidad
		if Input.is_action_just_pressed("cam_zoom"):
			_distancia = clamp(_distancia-salto_zoom,distancia_minima,distancia_maxima)
		if Input.is_action_just_pressed("cam_unzoom"):
			_distancia = clamp(_distancia+salto_zoom,distancia_minima,distancia_maxima)
	_rot_v = clamp(_rot_v,min_theta,max_theta)

func _physics_process(delta):
	horizontal.rotation_degrees.y = lerp(horizontal.rotation_degrees.y,_rot_h,aceleracion_rotacion*delta)
	vertical.rotation_degrees.x = lerp(vertical.rotation_degrees.x,_rot_v,aceleracion_rotacion*delta)
	
	if (clipear_camara && clip.is_colliding()):
		var distancia_clip = clip.global_transform.origin.distance_to(clip.get_collision_point())
		camara.transform.origin.z = lerp(camara.transform.origin.z,distancia_clip,velocidad_zoom*delta)
	else:
		camara.transform.origin.z = lerp(camara.transform.origin.z,_distancia,velocidad_zoom*delta)
	clip.target_position.z = camara.transform.origin.z

func get_collision_point():
	if mira.is_colliding():
		return mira.get_collision_point()
	else:
		return mira.to_global(mira.target_position)
