extends Estado

@export var estado_caminando: Estado
@export var estado_saltando: Estado
@export var estado_cayendo: Estado
@export var estado_impulso: Estado

func entrar():
	animacion = "idle"
	super()
	objetivo.velocity = Vector3.ZERO

func input() -> Estado:
	if InputController.salto:
		return estado_saltando
	return null

func physics_process(_delta) -> Estado:
	if InputController.movimiento != Vector2.ZERO:
		return estado_caminando
	if !objetivo.is_on_floor():
		return estado_cayendo
	return null
