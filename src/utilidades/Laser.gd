extends RayCast3D
@onready var haz = $Haz

@export var daño: int = 1
@export var duracion: float = 0.1

var prendido: bool = false
func _ready():
	prendido = true

func _process(delta):
	if !prendido:
		queue_free()
	var punto
	force_raycast_update()
	if is_colliding():
		punto = to_local(get_collision_point())
		haz.mesh.size.z = punto.z
		haz.position.z = punto.z/2
		var obj = get_collider()
		if(obj.is_in_group("Enemigos")):
			obj.golpe(daño)
	duracion -= delta
	if duracion <=0:
		prendido = false
