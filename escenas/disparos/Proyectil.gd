extends Disparo

@export var velocidad: float = 1000
@export var tiempo_vuelo: float = 10
@onready var proyectil = $Proyectil
@onready var mesh_instance_3d = $Proyectil/MeshInstance3D
const PROYECTIL = preload("res://escenas/disparos/Proyectil.tscn")
var disparado = false
var disparar = false
var tiempo_aire = 0
var divide = false
var cant_division = 0
@onready var proyectil2 = $"."

var actual_target = Vector3.ZERO

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
		if divide:
			for i in range(cant_division):
				actual_target.z = 20
				actual_target.x = 20
				var b = PROYECTIL.instantiate()
				self.add_child(b)
				b.look_at(actual_target+global_position, Vector3.UP)
	#queue_free()
