extends Disparo
class_name Proyectil
@export var tiempo_vuelo: float = 10

const PROYECTIL = preload("res://escenas/disparos/Proyectil.tscn")
@onready var proyectil = $Proyectil
var disparado = false
var disparar = false
var tiempo_aire = 0
var cant_division = 0
var actual_target = Vector3.ZERO

func _ready():
	set_as_top_level(true)
	for efecto in efectos_disparo:
		efecto.disparo = self
	disparar = true

func golpeando(body):	#ACA TENGO QUE CAMBIARLO POR ESTADISTICAS_ENEMIGO, CREAR ESTADISTICAS DEL ENEMIGO ETC.
	var pos_golpe = proyectil.global_position
	for efecto in efectos_disparo:
		efecto.pos_golpe = pos_golpe
		efecto.efecto_golpe(body)

func _physics_process(delta):
	if disparar:
		proyectil.apply_force(-transform.basis.z * magnitud, transform.basis.z)
		disparado = true
		disparar = false
	if disparado:
		tiempo_aire += delta
	if tiempo_aire > tiempo_vuelo:
		queue_free()

func _on_area_3d_body_entered(body):
	if body.is_in_group("Enemigos"):
		golpeando(body)
		body.golpe(daño)
		queue_free()

func nueva_instancia():
	return PROYECTIL.instantiate()
