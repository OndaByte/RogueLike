extends Marker3D

@export var paso_obj: Node3D
@export var paso_dist: float = 1
@export var pata_adyacente: Node3D
@export var pata_opuesta: Node3D

var pisando: bool = false


func _process(delta):
	var pos_obj = paso_obj.global_position
	if !pisando && !pata_adyacente.pisando && abs(global_position.distance_to(pos_obj)) >= paso_dist:
		var mitad = (global_position + pos_obj)/2
		var t = get_tree().create_tween()
		pisando = true
		t.tween_property(self, "global_position", mitad, 0.1)
		t.tween_property(self, "global_position", pos_obj, 0.1)
		t.tween_callback(func(): pisando = false)
