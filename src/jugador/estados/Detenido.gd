extends Estado

@export var estado_caminando: Estado
@export var estado_saltando: Estado
@export var estado_cayendo: Estado
@export var estado_impulso: Estado

func entrar():
	super()
	animacion = "idle"
	objetivo.velocity = Vector3.ZERO

func physics_process(delta) -> Estado:
	objetivo.velocity.y -= objetivo.gravity * delta
	if !objetivo.is_on_floor():
		return estado_cayendo
	if objetivo.controles.salto:
		return estado_saltando
	if objetivo.controles.movimiento != Vector2.ZERO:
		return estado_caminando
	return null
