extends Node3D
const cant_proyectiles = 3

func aplicar(arma):
	arma.cant_disparos += cant_proyectiles
	arma.dispersion_y = 0
	#arma.disparo.set_color(Color(40,114,51,100))

func _on_area_3d_body_entered(body):
	if body.is_in_group("Jugador"):
		body.arma.add_item(self)
	queue_free()
