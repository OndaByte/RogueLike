extends CharacterBody3D
class_name Jugador

@onready var animation_player = $modelo/player/AnimationPlayer
@onready var colision = $colision
@onready var modelo = $modelo
@onready var camara = $CamRot/Camara
@onready var maquna_estados_movimiento = $Movimiento
@onready var animations = $modelo/player/AnimationPlayer


@export var altura_salto: float = 5
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var cantidad_saltos: int = 20
@export var enfriamiento_salto: float = 0.01
@export var velocidad_maxima: float = 20
@export var velocidad_maxima_caminar: float = 4
@export var aceleracion_caminar: float = 3
@export var aceleracion_giro: float = 5
@export var velocidad_giro_camara: float = 8

func _ready():
	maquna_estados_movimiento.init(self)

func _physics_process(delta):
	maquna_estados_movimiento._physics_process(delta)
	move_and_slide()
