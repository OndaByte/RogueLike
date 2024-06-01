extends ItemArma

@export var cant_proyectiles:int = 3
@export var dispersion_x:float = 0.1
@export var dispersion_z:float = 0.1
@export var dispersion_y:float = 0.1
@export var enfriamiento: float = 1.3

func init(estadisticas):
	super(estadisticas)

func aplicar():
	estadisticas_arma.cant_disparos += cant_proyectiles
	estadisticas_arma.dispersion_y += dispersion_y
	estadisticas_arma.dispersion_x += dispersion_x 
	estadisticas_arma.dispersion_z += dispersion_z
	estadisticas_arma.enfriamiento *= enfriamiento

func _on_area_3d_body_entered(body):
	if body.is_in_group("Jugador"):
		body.agregar_item(self)
	queue_free()
