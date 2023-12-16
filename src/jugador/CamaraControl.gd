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

@onready var horizontal = $Horizontal
@onready var vertical = $Horizontal/Vertical
@onready var camara = $Horizontal/Vertical/Camera3D
@onready var controles = $"../../Controles"

var _rot_h: float = 0
var _rot_v: float = 0
var _capturando: bool = true
var _distancia: float = 0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_distancia = camara.transform.origin.z

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		_capturando != _capturando
		if _capturando:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if _capturando:
		if event is InputEventMouseMotion:
			_rot_h -= event.relative.x * sensibilidad
			_rot_v -= event.relative.y * sensibilidad
		if Input.is_action_just_pressed("cam_zoom"):
			_distancia = clamp(_distancia-salto_zoom,distancia_minima,distancia_maxima)
		if Input.is_action_just_pressed("cam_unzoom"):
			_distancia = clamp(_distancia+salto_zoom,distancia_minima,distancia_maxima)
	_rot_v = clamp(_rot_v,min_theta,max_theta)

func _physics_process(delta):
	horizontal.rotation_degrees.y = lerp(horizontal.rotation_degrees.y,_rot_h,aceleracion_rotacion*delta)
	vertical.rotation_degrees.x = lerp(vertical.rotation_degrees.x,_rot_v,aceleracion_rotacion*delta)
	camara.transform.origin.z = lerp(camara.transform.origin.z,_distancia,velocidad_zoom*delta)
