extends ItemArma

@export var efecto: EfectoDivision

func init(estadisticas):
	super(estadisticas)

func aplicar():
	estadisticas_arma.efectos_disparo.append(efecto)

func _on_area_3d_body_entered(body):
	if body.is_in_group("Jugador"):
		body.agregar_item(self)
	queue_free()
