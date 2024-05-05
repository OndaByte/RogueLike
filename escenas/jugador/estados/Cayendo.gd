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

func physics_process(delta) -> Estado:
	objetivo.velocity.y -= objetivo.gravity * delta
	
	if objetivo.is_on_floor():
		objetivo.contador_saltos = 0
		objetivo.enfriamiento_salto_real = 0
		if InputController.movimiento != Vector2.ZERO:
			return estado_caminando
		return estado_detenido
	
	if InputController.salto:
		if(objetivo.contador_saltos < objetivo.cantidad_saltos && objetivo.enfriamiento_salto_real <=0):
			return estado_saltando
	
	mov_dir = InputController.movimiento
	if mov_dir == Vector2.ZERO:
		return null
	
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
