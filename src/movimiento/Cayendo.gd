extends Estado

@export var estado_caminando: Estado
@export var estado_saltando: Estado
@export var estado_detenido: Estado
@export var estado_impulso: Estado

var mov_rot: float = 0
var mov_dir: Vector2 = Vector2.ZERO
var vel: Vector3 = Vector3.ZERO
var rotacion: float = 0

func entrar():
	animacion = "run"
	super()

func input() -> Estado:
	if InputController.salto:
		return estado_saltando
	return null

func physics_process(delta) -> Estado:
	objetivo.velocity.y -= objetivo.gravedad * delta
	mov_dir = InputController.movimiento
	if objetivo.is_on_floor():
		if mov_dir != Vector2.ZERO:
			return estado_caminando
		return estado_detenido
	if mov_dir != Vector2.ZERO:
		
		var direccion = Vector3(mov_dir.x, 0, mov_dir.y) #Calculo direccion de inputs
		mov_rot = lerp(mov_rot,deg_to_rad(objetivo.camara_rot_h),objetivo.velocidad_giro_camara*delta) #Roto en base a la camara
		direccion = direccion.rotated(Vector3.UP,mov_rot)
		vel = vel.lerp(direccion*objetivo.velocidad_maxima_caminar,objetivo.aceleracion_caminar*delta) #Calculo velocidad, esta es gradual no instantanea
		rotacion = lerp_angle(rotacion,atan2(-direccion.x,-direccion.z),objetivo.aceleracion_giro*delta)
		objetivo.rotation.y = rotacion
		
		objetivo.velocity.x = vel.x
		objetivo.velocity.z = vel.z
		if InputController.impulso && (objetivo.enfriamiento_impulso_real <= 0 || objetivo.contador_impulsos < objetivo.cantidad_impulsos):
			estado_impulso.direccion_dash = direccion
			return estado_impulso
	return null
