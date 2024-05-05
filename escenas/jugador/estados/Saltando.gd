extends Estado

@export var estado_cayendo: Estado
@export var estado_caminando: Estado
@export var estado_detenido: Estado
@export var estado_impulso: Estado

func entrar():
	super()
	animacion = "aim_idle"
	objetivo.velocity.y = objetivo.altura_salto
	objetivo.contador_saltos += 1
	objetivo.enfriamiento_salto_real = objetivo.enfriamiento_salto

func physics_process(delta):
	return estado_cayendo
