extends CSGBox3D

@export var proyectil = preload("res://escenas/proyectiles/Proyectil.tscn")
@export var enfriamiento: float = 3
var enfriamiento_actual: float = 0

func _ready():
	pass 

func disparar(target):
	if enfriamiento_actual > 0:
		return
	enfriamiento_actual = enfriamiento
	var b = proyectil.instantiate()
	add_child(b)
	b.look_at(target, Vector3.UP)
	b.disparar = true

func _process(delta):
	enfriamiento_actual -= delta*10
