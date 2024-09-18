extends CharacterBody3D
class_name Jugador

@onready var colision = $colision
@onready var modelo = $modelo
@onready var camara = $Camara
@onready var maquina_estados_movimiento = $Movimiento
@onready var animations = $modelo/player/AnimationPlayer
@onready var controles = get_node("/root/InputController")
@onready var arma = $modelo/Arma
@onready var impulso_ready = $Camara/Impulso_ready
@onready var impulso_enfriando = $Camara/Impulso_enfriando
@onready var salto_ready = $Camara/Salto_ready
@onready var salto_enfriando = $Camara/Salto_enfriando

@export var estadisticas: EstadisticasJugador

@onready var estadisticas_movimiento: EstadisticasMovimiento = estadisticas.estadisticas_movimiento
@export var items: Array[ItemInterface] = []

func agregar_item(item: ItemInterface):
	item.init(estadisticas)
	## ACA TENGO QUE CONTROLAR COMO SE APILAN LOS ITEMS (SI ES QUE QUIERO QUE SE APILEN)
	item.aplicar()
	items.append(item)

func _ready():
	estadisticas_movimiento.camara_rot_h = camara._rot_h
	arma.estadisticas = estadisticas.estadisticas_arma
	maquina_estados_movimiento.init(estadisticas_movimiento, animations)

func _input(event: InputEvent) -> void:
	maquina_estados_movimiento.input()

func _physics_process(delta):
	maquina_estados_movimiento.physics_process(delta)
	estadisticas_movimiento.enfriamiento_impulso_real -= delta 
	estadisticas_movimiento.enfriamiento_salto_real-= delta
	velocity = estadisticas_movimiento.velocity
	modelo.rotation.y = estadisticas_movimiento.rotation.y
	
	estadisticas_movimiento.camara_rot_h = camara._rot_h
	if (estadisticas_movimiento.enfriamiento_impulso_real <= 0):
		impulso_ready.visible = true
		impulso_enfriando.visible = false
	else:
		impulso_ready.visible = false
		impulso_enfriando.visible = true
	
	if (estadisticas_movimiento.enfriamiento_salto_real <= 0):
		salto_ready.visible = true
		salto_enfriando.visible = false
	else:
		salto_ready.visible = false
		salto_enfriando.visible = true
	
	arma.mira = camara.get_collision_point()
	if controles.disparando:
		arma.disparar()
	move_and_slide()
	
	estadisticas_movimiento.cayendo = !self.is_on_floor()
