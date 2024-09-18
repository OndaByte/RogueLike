extends EfectoDisparo
class_name EfectoDivision

@export var cant_divisiones: int = 6
@export var magnitud_hijos: float = 1
@export var daño_hijos: float = 1

func efecto_golpe(body):
	if disparo == null:
		return
	var aux_dispersion = 2*PI * randf()
	var angulo
	var actual_target
	if apila && body.cant_efectos(nombre_efecto) > tope_pila:
		return
	body.agregar_efecto(nombre_efecto)
	for i in range(cant_divisiones):
		var disparo_hijo = disparo.nueva_instancia()
		disparo_hijo.daño =  disparo.daño * daño_hijos
		disparo_hijo.magnitud *= magnitud_hijos
		disparo_hijo.efectos_disparo = disparo.efectos_disparo
		angulo = i * (2 * PI / cant_divisiones) + aux_dispersion
		actual_target = Vector3(cos(angulo), 0, sin(angulo)).normalized().rotated(Vector3(1,0,0),aux_dispersion)
		padre_disparo.add_child(disparo_hijo)
		disparo_hijo.look_at_from_position(pos_golpe,actual_target+pos_golpe,Vector3.UP)
		disparo_hijo.global_position = pos_golpe
