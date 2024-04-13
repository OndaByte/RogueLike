extends RigidBody3D

@export var daño: int = 10
@export var velocidad: float = 1000
@export var tiempo_vuelo: float = 10

var disparado = false
var disparar = false
var tiempo_aire = 0

func _ready():
	set_as_top_level(true)

func _physics_process(delta):
	if disparar:
		apply_force(-transform.basis.z*velocidad, transform.basis.z)
		disparado = true
		disparar = false
	if disparado:
		tiempo_aire += delta
	if tiempo_aire > tiempo_vuelo:
		queue_free()


func _on_area_3d_body_entered(body):
	if body.is_in_group("Enemigos"):
		body.golpe(daño)
		queue_free() #Libero de memoria el proyectil al impactar
