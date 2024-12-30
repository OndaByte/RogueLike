extends CharacterBody3D
class_name Agente

@export var distancia_max: float = 0.5
@export var distancia_min: float = 0.2
@export var variacion: float = 45
@export var velocidad: float = 1
@export var angulo_vel: float = 2

@export var peso_separacion: float = 10
@export var peso_alineacion: float = 10
@export var peso_agrupacion: float = 100
@onready var csg_cylinder_3d: CSGCylinder3D = $CSGCylinder3D

static var contador_id: int = 0

var id: int
var tiempo: float = 0.25
var dir: Vector3 = Vector3()
var vecinos: Array[Agente] = []

func _init() -> void:
	id = contador_id
	contador_id += 1

func _process(delta: float) -> void:
	tiempo -= delta
	translate(Vector3(0, 0, -1) * velocidad * delta)
	calcular_direccion()
	if tiempo < 0:
		tiempo = 1
	if(dir.x != 0 || dir.y != 0 || dir.z != 0):
		global_transform.basis = global_transform.basis.slerp(global_transform.looking_at(dir+global_position, Vector3.UP).basis, 0.1)

func calcular_direccion() -> void:
	if tiempo <= 0:
		var angulo_aleatorio = randf_range(-variacion, variacion)
		var eje_rotacion = Vector3.UP
		var rotacion = Quaternion(eje_rotacion, angulo_aleatorio)
		dir = rotacion* transform.basis.z
		eje_rotacion = Vector3.RIGHT
		rotacion = Quaternion(eje_rotacion, angulo_aleatorio)
		dir = rotacion* transform.basis.z
	if vecinos.size() == 0:
		return
	var aux: float
	var dir_vecino: Vector3
	var distancia: float
	var centro_enjambre: Vector3 = Vector3()
	for v in vecinos:
		centro_enjambre += v.global_position
		dir_vecino = v.global_position - global_position
		distancia = dir_vecino.length()
		if distancia < distancia_min: #Si estan muy cerca
			aux = clampf(distancia/ distancia_min, 0, 1)
			dir -= aux * dir_vecino * peso_separacion
		elif distancia > distancia_max: #Si estan muy lejos
			aux = clampf(distancia/ distancia_max, 0, 1)
			dir += aux * v.dir * peso_alineacion
	
	centro_enjambre = centro_enjambre/vecinos.size() - global_position
	
	dir += centro_enjambre * peso_agrupacion
	dir = dir.normalized()
	
func _on_cercanos_body_entered(body: Node3D) -> void:
	if(body == self):
		return
	if body.is_in_group("Enjambre"):
		vecinos.append(body)

func _on_cercanos_body_exited(body: Node3D) -> void:
	if body.is_in_group("Enjambre"):
		vecinos.erase(body)



#func _on_vision_body_entered(body: Node3D) -> void:
	#var vecino_pos: Vector3 = body.global_position
	#var aux_distancia: float
	#var aux_direccion: Vector3
	#var direccion = Vector3.ZERO
	#if body.is_in_group("Enjambre"):
		#aux_distancia = global_position.distance_to(vecino_pos)
		#if aux_distancia > distancia_max:
			#aux_direccion = global_position.direction_to(vecino_pos)
