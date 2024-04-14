extends Node3D

@onready var boca_arma = $Arma/Boca_arma
@export var disparo = preload("res://escenas/disparos/Proyectil.tscn")
@export var enfriamiento: float = 3
@export var cant_disparos: float = 1
@export var dispersion: float = 0.05
@export var laser: bool = false

var enfriamiento_actual: float = 0
var duracion_laser: float = 5

func _ready():
	dispersion /= 100
	pass 

func disparar(target):
	if enfriamiento_actual > 0:
		return
	enfriamiento_actual = enfriamiento
	var real_target = target - to_global(boca_arma.position)
	for i in range(cant_disparos):
		var actual_target = 2*real_target.normalized()
		actual_target.x += randf_range(-dispersion,dispersion)
		actual_target.y += randf_range(-dispersion,dispersion)
		actual_target.z += randf_range(-dispersion,dispersion)
		var b = disparo.instantiate()
		boca_arma.add_child(b)
		b.look_at(actual_target+to_global(boca_arma.position), Vector3.UP)

func _process(delta):
	enfriamiento_actual -= delta*10
