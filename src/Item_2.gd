extends Node3D
const cant_division = 5

func aplicar(arma):
	arma.divide = true
	arma.cant_division = cant_division

func _on_area_3d_body_entered(body):
	if body.is_in_group("Jugador"):
		body.arma.add_item(self)
	queue_free()
