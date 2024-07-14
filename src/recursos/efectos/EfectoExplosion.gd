extends EfectoDisparo
class_name EfectoExplosion

@export var radio_explosion = 3


func efecto_golpe(_target):	
	if disparo == null:
		return
	
	var sphere_instance = MeshInstance3D.new()
	var sphere_mesh = SphereMesh.new()
	sphere_mesh.radius = radio_explosion
	sphere_mesh.height = radio_explosion*2
	sphere_instance.mesh = sphere_mesh
	
	padre_disparo.add_child(sphere_instance)
	sphere_instance.global_position = pos_golpe
	sphere_instance.set_as_top_level(true)
