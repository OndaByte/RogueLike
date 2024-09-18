extends Estado

@export var estado_caminando: Estado
@export var estado_saltando: Estado
@export var estado_detenido: Estado
@export var estado_cayendo: Estado

var tiempo_transcurrido: float = 0.0 ##Usado para calcular la duracion del impulso/dash
var direccion_dash: Vector3 = Vector3.ZERO

var mov_rot: float = 0
var mov_dir: Vector2 = Vector2.ZERO
var vel: Vector3 = Vector3.ZERO
var rotacion: float = 0

func entrar():
	animacion = "aim_walk"
	super()
	tiempo_transcurrido = 0.0
	objetivo.velocity.y = 0
	if objetivo.enfriamiento_impulso_real <= 0:
		objetivo.contador_impulsos = 0
	objetivo.enfriamiento_impulso_real = objetivo.enfriamiento_impulso
	objetivo.contador_impulsos += 1
	objetivo.velocity = direccion_dash * objetivo.velocidad_impulso

func physics_process(delta):
	tiempo_transcurrido += delta
	
	mov_dir = InputController.movimiento
	if tiempo_transcurrido <= objetivo.tiempo_impulso:
		
		if mov_dir != Vector2.ZERO:
			
			var direccion = Vector3(mov_dir.x, 0, mov_dir.y) #Calculo direccion de inputs
			mov_rot = lerp(mov_rot,deg_to_rad(objetivo.camara_rot_h),objetivo.velocidad_giro_camara*delta) #Roto en base a la camara
			direccion = direccion.rotated(Vector3.UP,mov_rot)
			vel = vel.lerp(direccion*objetivo.velocidad_maxima_caminar,objetivo.aceleracion_caminar*delta) #Calculo velocidad, esta es gradual no instantanea
			rotacion = lerp_angle(rotacion,atan2(-direccion.x,-direccion.z),objetivo.aceleracion_giro*delta)
			
			objetivo.rotation.y = rotacion
		return null
	if mov_dir != Vector2.ZERO:
		return estado_caminando
	return estado_detenido
