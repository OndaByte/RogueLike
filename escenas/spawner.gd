extends Area3D

@export var node_to_spawn: PackedScene
@export var cant: int = 200
var radio = 3
var tiempo: float = 0.1
var rng = RandomNumberGenerator.new()

func _process(delta: float) -> void:
	if cant <= 0:
		return
	tiempo -= delta
	if tiempo > 0:
		return
	var instance = node_to_spawn.instantiate()
	instance.position = global_transform.origin
	get_tree().current_scene.add_child(instance)
	instance.look_at(Vector3(rng.randf_range(-100,100),rng.randf_range(-100,100),rng.randf_range(-100,100)), Vector3.UP)
	cant -= 1
	tiempo = 0.1

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("Enjambre"):  # Asegúrate de que los nodos tengan el grupo adecuado
		reposition_body(body)

func reposition_body(body: Node) -> void:
	var current_position = body.global_position
	var dir = current_position - global_position
	if dir.length() > radio:
		body.global_position = current_position - dir*1.5
	
