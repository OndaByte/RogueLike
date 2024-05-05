extends Estado

@export var estado_cayendo: Estado
@export var estado_detenido: Estado
@export var estado_saltando: Estado
@export var estado_impulso: Estado

var mov_rot: float = 0
var mov_dir: Vector2 = Vector2.ZERO
var vel: Vector3 = Vector3.ZERO
var rotacion: float = 0

func entrar():
	animacion = "walk"
	objetivo.velocity.y = 0
	super()

func physics_process(delta):
	if InputController.salto:
		return estado_saltando
	
	mov_dir = InputController.movimiento
	if mov_dir == Vector2.ZERO:
		return estado_detenido
	
	var direccion = Vector3(mov_dir.x, 0, mov_dir.y) #Calculo direccion de inputs
	mov_rot = lerp(mov_rot,deg_to_rad(objetivo.camara_rot_h),objetivo.velocidad_giro_camara*delta) #Roto en base a la camara
	direccion = direccion.rotated(Vector3.UP,mov_rot)
	vel = vel.lerp(direccion*objetivo.velocidad_maxima_caminar,objetivo.aceleracion_caminar*delta) #Calculo velocidad, esta es gradual no instantanea
	
	rotacion = lerp_angle(rotacion,atan2(-direccion.x,-direccion.z),objetivo.aceleracion_giro*delta)
	objetivo.rotation.y = rotacion
	objetivo.velocity = vel
	
	if InputController.impulso && (objetivo.enfriamiento_impulso <= 0 || objetivo.contador_impulsos < objetivo.cantidad_impulsos):
		estado_impulso.direccion_dash = direccion
		return estado_impulso
	
	if !objetivo.is_on_floor():
		return estado_cayendo

	return null
