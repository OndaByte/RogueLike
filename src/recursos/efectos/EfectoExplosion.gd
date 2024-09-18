extends EfectoDisparo
class_name EfectoExplosion

@export var radio_explosion = 3
var explosion = preload("res://escenas/efectos/Explosion.tscn")

func efecto_golpe(_target):
	if disparo == null:
		return
	var instancia = explosion.instantiate()
	padre_disparo.add_child(instancia)
	instancia.global_position = pos_golpe
	instancia.set_as_top_level(true)
