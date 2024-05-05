extends EfectoDisparo
class_name EfectoDivision

@export var cant_divisiones = 6

var pos_golpe: Vector3

func efecto_golpe(_target):
	var disparo_padre = disparo.nueva_instancia()
	var boca_arma = disparo.get_parent()
	for i in range(cant_divisiones):
		var disparo_hijo = disparo_padre.nueva_instancia()
		disparo_hijo.magnitud /= 10
		var angulo = i * (2 * PI / cant_divisiones)
		var actual_target = Vector3(cos(angulo), 0, sin(angulo)).normalized()
		boca_arma.add_child(disparo_hijo)
		disparo_hijo.look_at_from_position(pos_golpe,actual_target+pos_golpe,Vector3.UP)
		disparo_hijo.global_position = pos_golpe
	disparo_padre.queue_free()
