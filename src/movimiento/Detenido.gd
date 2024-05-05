extends Estado

@export var estado_caminando: Estado
@export var estado_saltando: Estado
@export var estado_cayendo: Estado
@export var estado_impulso: Estado

func entrar():
	animacion = "idle"
	super()
	objetivo.velocity = Vector3.ZERO

func physics_process(_delta) -> Estado:
	if !objetivo.is_on_floor():
		return estado_cayendo
	if InputController.salto:
		return estado_saltando
	if InputController.movimiento != Vector2.ZERO:
		return estado_caminando
	return null
