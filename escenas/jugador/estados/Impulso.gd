extends Estado

@export var estado_caminando: Estado
@export var estado_saltando: Estado
@export var estado_detenido: Estado
@export var estado_cayendo: Estado

var tiempo_transcurrido: float = 0.0 ##Usado para calcular la duracion del impulso/dash
var direccion_dash: Vector3 = Vector3.ZERO

func entrar():
	super()
	animacion = "aim_walk"
	tiempo_transcurrido = 0.0
	objetivo.velocity.y = 0
	if objetivo._enfriamiento_impulso <= 0:
		objetivo.contador_impulsos = 0
	objetivo._enfriamiento_impulso = objetivo.enfriamiento_impulso
	objetivo.contador_impulsos += 1

func physics_process(delta):
	tiempo_transcurrido += delta
	if tiempo_transcurrido <= objetivo.tiempo_impulso:
		objetivo.velocity = direccion_dash * objetivo.velocidad_impulso
		return null
	else:
		return estado_detenido
