extends RayCast3D

@export var paso_obj: Node3D

func _physics_process(_delta):
	var colision = get_collision_point()
	if colision:
		paso_obj.global_position = colision
