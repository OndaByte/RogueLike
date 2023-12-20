extends Estado

@export var estado_caminando: Estado
@export var estado_saltando: Estado
@export var estado_detenido: Estado
@export var estado_impulso: Estado

func entrar():
	super()
	animacion = "run"

func physics_process(delta) -> Estado:
	objetivo.velocity.y -= objetivo.gravity * delta
	
	if objetivo.is_on_floor():
		objetivo.contador_saltos = 0
		objetivo._enfriamiento_salto = 0
		if objetivo.controles.movimiento != Vector2.ZERO:
			return estado_caminando
		return estado_detenido
	
	#if objetivo.controles.movimiento == Vector2.ZERO:
	
	if objetivo.controles.salto:
		if(objetivo.contador_saltos < objetivo.cantidad_saltos && objetivo._enfriamiento_salto <=0):
			return estado_saltando
	return null
