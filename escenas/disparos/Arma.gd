extends Node3D
class_name Arma

@onready var boca_arma = $Boca_arma
@export var disparo = preload("res://escenas/disparos/Proyectil.tscn")

@export var enfriamiento: float = 3
@export var cant_disparos: float = 1
@export var dispersion_x: float = 1
@export var dispersion_y: float = 1
@export var dispersion_z: float = 1
@export var laser: bool = false

var mira: Vector3
var enfriamiento_actual: float = 0
var laseres = []
var items= []
var divide = false
var cant_division = 0

func _ready():
	dispersion_x /= 100
	dispersion_y /= 100
	dispersion_z /= 100
	if laser:
		for i in range(cant_disparos):
			var d = disparo.instantiate()
			d.prendido = false
			boca_arma.add_child(d)
			laseres.append(d)

func disparar():
	if enfriamiento_actual > 0:
		return
	enfriamiento_actual = enfriamiento
	var real_target = boca_arma.global_position.direction_to(mira)
	for i in range(cant_disparos):
		var actual_target = real_target.normalized()
		actual_target.x += randf_range(-dispersion_x,dispersion_x)
		actual_target.y += randf_range(-dispersion_y,dispersion_y)
		actual_target.z += randf_range(-dispersion_z,dispersion_z)
		if laser:
			laseres[i].prendido = true
			laseres[i].duracion_real = laseres[i].duracion
			laseres[i].global_transform.basis = laseres[i].global_transform.basis.slerp(laseres[i].global_transform.looking_at(actual_target+boca_arma.global_position, Vector3.UP).basis, 0.05)
		else:
			var b = disparo.instantiate()
			b.divide = divide
			b.cant_division = cant_division
			boca_arma.add_child(b)
			b.look_at(actual_target+boca_arma.global_position, Vector3.UP)

func add_item(item):
	item.aplicar(self)
	items.append(item)

func _process(delta):
	enfriamiento_actual -= delta*10

func _physics_process(delta):
	global_transform.basis = global_transform.basis.slerp(global_transform.looking_at(mira, Vector3.UP).basis, 0.5)
