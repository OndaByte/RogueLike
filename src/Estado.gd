extends Node
class_name Estado

var animacion: String
var objetivo: Resource
var animaciones: AnimationMixer

func entrar():
	animaciones.play(animacion)

func salir():
	pass

func input(event) -> Estado:
	return null

func unhandled_input(event) -> Estado:
	return null

func process(delta) -> Estado:
	return null

func physics_process(delta) -> Estado:
	return null

func get_maquina_estados(nodo):
	pass
