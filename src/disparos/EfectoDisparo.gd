extends Resource
class_name EfectoDisparo

var disparo: Disparo
var padre_disparo: Node3D

func efecto_golpe(_target):
	push_error("Error EfectoDisparo: Metodo efecto_golpe(target) debe ser implementado")
