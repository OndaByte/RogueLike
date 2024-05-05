extends Node3D
class_name Arma

@onready var boca_arma = $Boca_arma
@export var disparo = preload("res://escenas/disparos/Proyectil.tscn")
var estadisticas: EstadisticasArma

var mira: Vector3
var laseres = []

func disparar():
	if estadisticas.enfriamiento_actual > 0:
		return
	estadisticas.enfriamiento_actual = estadisticas.enfriamiento
	var real_target = boca_arma.global_position.direction_to(mira)
	for i in range(estadisticas.cant_disparos):
		var actual_target = real_target.normalized()
		actual_target.x += randf_range(-estadisticas.dispersion_x,estadisticas.dispersion_x)
		actual_target.y += randf_range(-estadisticas.dispersion_y,estadisticas.dispersion_y)
		actual_target.z += randf_range(-estadisticas.dispersion_z,estadisticas.dispersion_z)
		var b = disparo.instantiate()
		b.daño = estadisticas.daño_disparo
		b.efectos_disparo = estadisticas.efectos_disparo
		boca_arma.add_child(b)
		b.look_at(actual_target+boca_arma.global_position, Vector3.UP)

func _physics_process(delta):
	global_transform.basis = global_transform.basis.slerp(global_transform.looking_at(mira, Vector3.UP).basis, 0.5)
	estadisticas.enfriamiento_actual -= delta
