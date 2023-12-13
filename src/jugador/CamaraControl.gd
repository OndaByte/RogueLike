extends Node3D
class_name CamaraControl

@export var max_theta: float = 75
@export var min_theta: float = -90
@export var vel_rot: float = 10
@export var mouse_sen: float = 0.1
@export var vel_zoom: float = 10
@export var step_zoom: float = 0.5
@export var min_dist: float = 2
@export var max_dist: float = 10

@onready var horizontal = $Horizontal
@onready var vertical = $Horizontal/Vertical
@onready var camara = $Horizontal/Vertical/Camera3D

var _rot_h: float = 0
var _rot_v: float = 0
var _capturando: bool = true
var _distancia: float = 0

func _ready():
	await(get_parent())
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
			_rot_h -= event.relative.x * mouse_sen
			_rot_v -= event.relative.y * mouse_sen
		if Input.is_action_just_pressed("cam_zoom"):
			_distancia = clamp(_distancia-step_zoom,min_dist,max_dist)
		if Input.is_action_just_pressed("cam_unzoom"):
			_distancia = clamp(_distancia+step_zoom,min_dist,max_dist)
	_rot_v = clamp(_rot_v,min_theta,max_theta)

func _physics_process(delta):
	horizontal.rotation_degrees.y = lerp(horizontal.rotation_degrees.y,_rot_h,vel_rot*delta)
	vertical.rotation_degrees.x = lerp(vertical.rotation_degrees.x,_rot_v,vel_rot*delta)
	camara.transform.origin.z = lerp(camara.transform.origin.z,_distancia,vel_zoom*delta)
