extends Disparo
@onready var laser = $Laser
@onready var haz = $Laser/Haz

@export var duracion: float = 10

var prendido: bool = false
var duracion_real: float = duracion

func _ready():
	haz.mesh.size.z = 0.0
	haz.position.z = 0

func _process(delta):
	if !prendido:
		haz.mesh.size.z = 0.0
		haz.position.z = 0
		return
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
	duracion_real -= delta*10
	if duracion_real <=0:
		prendido = false
