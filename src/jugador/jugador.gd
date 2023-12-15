extends CharacterBody3D
class_name Jugador

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var animation_player = $modelo/player/AnimationPlayer
@onready var colision = $colision
@onready var modelo = $modelo
@onready var camara = $CamRot/Camara

@export var mov_vel: float = 3
@export var giro_vel: float = 4
@export var mov_acc: float = 2.5
@export var max_vel: float = 10
@export var max_salto: float = 5
@export var cant_saltos: int = 2
@export var salto_enfriamiento: float = 0.2
@export var mouse_sen: float = 0.5
@export var zoom_vel: float = 0.05
@export var max_zoom: float = 3
@export var min_zoom: float = 2
@export var min_theta_cam: float = -1.5
@export var max_theta_cam: float = PI/4
@export var vel_cam_seguimiento: float = 8

var _mov_dir: Vector2 = Vector2.ZERO
var _vel: Vector3 = Vector3.ZERO
var _y_vel: float = 0
var _salto: bool = false
var _rotacion: float = 0
var _cont_saltos: int  = 0
var _salto_enfriamiento: float = 0
var _mov_rot: float = 0

func _process(delta):
	_mov_dir = Input.get_vector("izquierda", "derecha", "adelante", "atras").normalized()
	_salto = Input.is_action_just_pressed("salto")
	
func _physics_process(delta):
	var direccion = Vector3(_mov_dir.x, 0, _mov_dir.y) #Calculo direccion de inputs
	_mov_rot = lerp(_mov_rot,deg_to_rad(camara._rot_h),vel_cam_seguimiento*delta) #Roto en base a la camara
	direccion = direccion.rotated(Vector3.UP,_mov_rot)
	_vel = _vel.lerp(direccion*mov_vel,mov_acc*delta) #Calculo velocidad, esta es gradual no instantanea
	if _salto_enfriamiento > 0:
		_salto_enfriamiento -= delta
	if not is_on_floor():
		_y_vel -= gravity * delta
	else:
		_y_vel = 0
		_cont_saltos = 0
		_salto_enfriamiento = 0
	if _salto && _cont_saltos < cant_saltos && _salto_enfriamiento <=0:
		_salto = false
		_y_vel = max_salto
		_cont_saltos += 1
		_salto_enfriamiento = salto_enfriamiento
		
	if _mov_dir != Vector2.ZERO:
		_rotacion = lerp_angle(_rotacion,atan2(-direccion.x,-direccion.z),giro_vel*delta)
		modelo.rotation.y = _rotacion
	_vel.y = _y_vel
	velocity = _vel
	move_and_slide()
