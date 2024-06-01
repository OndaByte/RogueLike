extends EfectoDisparo
class_name EfectoDivision

@export var cant_divisiones: int = 6
@export var magnitud_hijos: float = 1
@export var daño_hijos: float = 1

var pos_golpe: Vector3

func efecto_golpe(_target):
	for i in range(cant_divisiones):
		var disparo_hijo = disparo.nueva_instancia()
		disparo_hijo.daño =  disparo.daño * daño_hijos
		disparo_hijo.magnitud *= magnitud_hijos
		disparo_hijo.efectos_disparo = disparo.efectos_disparo
		var angulo = i * (2 * PI / cant_divisiones)
		var actual_target = Vector3(cos(angulo), 0, sin(angulo)).normalized()
		padre_disparo.add_child(disparo_hijo)
		disparo_hijo.look_at_from_position(pos_golpe,actual_target+pos_golpe,Vector3.UP)
		disparo_hijo.global_position = pos_golpe
	#disparo.queue_free()
