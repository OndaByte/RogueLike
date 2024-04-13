extends CharacterBody3D
class_name Jugador

@onready var animation_player = $modelo/player/AnimationPlayer
@onready var colision = $colision
@onready var modelo = $modelo
@onready var camara = $CamRot/Camara
@onready var maquina_estados_movimiento = $Movimiento
@onready var animations = $modelo/player/AnimationPlayer
@onready var controles = $Controles
@onready var arma = $modelo/Arma

@export var altura_salto: float = 5
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var cantidad_saltos: int = 2
@export var enfriamiento_salto: float = 0.01
@export var velocidad_maxima: float = 20
@export var velocidad_maxima_caminar: float = 4
@export var aceleracion_caminar: float = 3
@export var aceleracion_giro: float = 5
@export var velocidad_giro_camara: float = 8
@export var tiempo_impulso: float = 0.2
@export var velocidad_impulso: float = 40.0
@export var enfriamiento_impulso: float = 0.5
@export var cantidad_impulsos: int = 2

var contador_saltos: int = 0
var contador_impulsos: int = 0
var _enfriamiento_salto: float = 0
var _enfriamiento_impulso: float = 0

func _ready():
	maquina_estados_movimiento.init(self, animations)

func _physics_process(delta):
	maquina_estados_movimiento.physics_process(delta)
	_enfriamiento_impulso -= delta 
	_enfriamiento_salto -= delta
	
	if controles.disparando:
		if camara.mira.is_colliding():
			arma.disparar(camara.mira.get_collision_point())
		else:
			arma.disparar(camara.mira.to_global(camara.mira.target_position))
	move_and_slide()
