extends Disparo

@export var velocidad: float = 1000
@export var tiempo_vuelo: float = 10
@onready var proyectil = $Proyectil

var disparado = false
var disparar = false
var tiempo_aire = 0

func _ready():
	set_as_top_level(true)
	disparar = true

func _physics_process(delta):
	if disparar:
		proyectil.apply_force(-transform.basis.z*velocidad, transform.basis.z)
		disparado = true
		disparar = false
	if disparado:
		tiempo_aire += delta
	if tiempo_aire > tiempo_vuelo:
		queue_free()

func _on_area_3d_body_entered(body):
	if body.is_in_group("Enemigos"):
		body.golpe(daño)
		queue_free()
