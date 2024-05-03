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
@onready var arma_2 = $modelo/Arma2
@onready var impulso_ready = $CamRot/Camara/Impulso_ready
@onready var impulso_enfriando = $CamRot/Camara/Impulso_enfriando
@onready var salto_ready = $CamRot/Camara/Salto_ready
@onready var salto_enfriando = $CamRot/Camara/Salto_enfriando

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
	
	if (_enfriamiento_impulso <= 0):
		impulso_ready.visible = true
		impulso_enfriando.visible = false
	else:
		impulso_ready.visible = false
		impulso_enfriando.visible = true
		
	if (_enfriamiento_salto <= 0):
		salto_ready.visible = true
		salto_enfriando.visible = false
	else:
		salto_ready.visible = false
		salto_enfriando.visible = true
		
	if camara.mira.is_colliding():
		arma.mira = camara.mira.get_collision_point()
		arma_2.mira = camara.mira.get_collision_point()
	else:
		arma.mira = camara.mira.to_global(camara.mira.target_position)
		arma_2.mira = camara.mira.to_global(camara.mira.target_position)
	if controles.disparando:
		arma.disparar()
	if controles.disparando2:
		arma_2.disparar()
	move_and_slide()
