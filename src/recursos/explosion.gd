extends Node3D
@onready var area_3d: Area3D = $Area3D

@export var radio_max: float = 5
@export var vel_exp: float = 20

var aux: float = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if aux >= radio_max:
		queue_free()
	aux += vel_exp*delta
	area_3d.scale = Vector3(aux,aux,aux);
