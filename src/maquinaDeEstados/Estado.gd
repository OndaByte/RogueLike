extends Node
class_name Estado

var animacion: String
var objetivo: Object
var animaciones: AnimationMixer

func entrar() -> void:
	animaciones.play(animacion)

func salir() -> void:
	pass

func input() -> Estado:
	return null

func process(delta: float) -> Estado:
	return null

func physics_process(delta: float) -> Estado:
	return null

func get_maquina_estados(_nodo):
	pass
