extends RigidBody3D

@export var daño: float = 10
@export var velocidad: float = 50
@export var tiempo_vuelo: float = 30

var disparado = false
var tiempo_aire = 0

func _ready():
	top_level = true

func _physics_process(delta):
	if disparado:
		apply_impulse(transform.basis.z, -transform.basis.z)
		tiempo_aire += delta
	if tiempo_aire > tiempo_vuelo:
		queue_free()


func _on_area_3d_body_entered(body):
	#Logica de daño a los enemigos y etc
	queue_free() #Libero de memoria el proyectil al impactar
