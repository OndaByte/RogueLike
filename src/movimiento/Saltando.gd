extends Estado

@export var estado_cayendo: Estado
@export var estado_caminando: Estado
@export var estado_detenido: Estado
@export var estado_impulso: Estado

func entrar():
	if(objetivo.is_on_floor()):
		objetivo.contador_saltos = 0
		objetivo.enfriamiento_salto_real = 0
	if(objetivo.contador_saltos < objetivo.cantidad_saltos && objetivo.enfriamiento_salto_real <=0):
		animacion = "aim_idle"
		objetivo.contador_saltos += 1
		objetivo.enfriamiento_salto_real = objetivo.enfriamiento_salto
		super()
		objetivo.velocity.y = objetivo.altura_salto

func physics_process(delta):
	return estado_cayendo
