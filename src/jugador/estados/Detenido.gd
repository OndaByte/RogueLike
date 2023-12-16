extends Estado

@export var estado_caminando: Estado
@export var estado_saltando: Estado

func entrar():
	super()
	animacion = "idle"
	objetivo.velocity = Vector3.ZERO

func input(event: InputEvent) -> Estado:
	if Input.is_action_just_pressed("salto") || objetivo.is_on_floor():
		return estado_saltando
	if Input.get_vector("izquierda", "derecha", "adelante", "atras") != Vector2.ZERO:
		return estado_caminando
	return null

func physics_process(delta) -> Estado:
	objetivo.velocity.y -= objetivo.gravity * delta
	if !objetivo.is_on_floor():
		return estado_saltando
	return null
