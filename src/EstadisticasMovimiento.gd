extends Resource
class_name EstadisticasMovimiento

@export var gravity: float = 10
@export var altura_salto: float = 5
@export var cantidad_saltos: int = 2
@export var enfriamiento_salto: float = 0.01
@export var velocidad_maxima: float = 20
@export var velocidad_maxima_caminar: float = 4
@export var aceleracion_caminar: float = 3
@export var aceleracion_giro: float = 5
@export var velocidad_giro_camara: float = 8
@export var tiempo_impulso: float = 0.2
@export var velocidad_impulso: float = 40.0
@export var enfriamiento_impulso: float = 0.5
@export var cantidad_impulsos: int = 2
@export var cayendo: bool = false

var velocity: Vector3 = Vector3.ZERO
var rotation: Vector3 = Vector3.ZERO
var camara_rot_h: float = 0
var contador_saltos: int = 0
var contador_impulsos: int = 0
var enfriamiento_salto_real: float = 0
var enfriamiento_impulso_real: float = 0

func is_on_floor():
	return !cayendo
