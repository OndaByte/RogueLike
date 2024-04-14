extends Disparo
@onready var laser = $Laser
@onready var haz = $Laser/Haz

@export var duracion: float = 0.1

var prendido: bool = false
func _ready():
	prendido = true

func _process(delta):
	if !prendido:
		queue_free()
	var punto
	laser.force_raycast_update()
	if laser.is_colliding():
		punto = to_local(laser.get_collision_point())
		var obj = laser.get_collider()
		if(obj.is_in_group("Enemigos")):
			obj.golpe(daño)
	else:
		punto = laser.target_position
	haz.mesh.size.z = punto.z
	haz.position.z = punto.z/2
	duracion -= delta
	if duracion <=0:
		prendido = false
