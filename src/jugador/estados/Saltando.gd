extends Estado

@export var estado_caminando: Estado
@export var estado_detenido: Estado

var contador_saltos: int = 0
var enfriamiento: float = 0

func entrar():
	super()
	animacion = "aim_idle"
	objetivo.velocity.y = objetivo.altura_salto

func physics_process(delta):
	objetivo.velocity.y -= objetivo.gravity * delta
	
	var salto: bool = Input.is_action_just_pressed("salto")
	
	if(!salto && objetivo.is_on_floor()):
		contador_saltos = 0
		enfriamiento = 0
		if Input.get_vector("izquierda", "derecha", "adelante", "atras") != Vector2.ZERO:
			return estado_caminando
		return estado_detenido
	
	enfriamiento -= delta
	if(salto && contador_saltos < objetivo.cantidad_saltos && enfriamiento <=0):
		objetivo.velocity.y = objetivo.altura_salto
		contador_saltos += 1
		enfriamiento = objetivo.enfriamiento_salto
		return self
	return null
