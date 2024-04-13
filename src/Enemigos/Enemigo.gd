extends CharacterBody3D

@onready var agente = $NavigationAgent3D

@export var velocidad: float = 3
@export var acelerecaion: float = 15
@export var vel_rotacion: float = 3
@export var objetivo: Node3D = null
@export var vida: int = 1000

var direccion: Vector3 = Vector3()
var rotacion: float = 0
var vida_actual

func _ready():
	vida_actual = vida
func golpe(daño: int):
	vida_actual -= daño

func _physics_process(delta):
	if vida_actual <=0:
		queue_free()
	
	agente.target_position = objetivo.global_position
	direccion = agente.get_next_path_position() - global_position
	direccion = direccion.normalized()
	velocity = velocity.lerp(direccion*velocidad, acelerecaion*delta)
	
	rotacion = lerp_angle(rotacion,atan2(-direccion.x,-direccion.z),vel_rotacion*delta)
	rotation.y = rotacion
	
	move_and_slide()
