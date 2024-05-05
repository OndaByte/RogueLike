extends Node
class_name Estado

var animacion: String
var objetivo: Resource
var animaciones: AnimationMixer

func entrar():
	animaciones.play(animacion)

func salir():
	pass

func input(_event) -> Estado:
	return null

func unhandled_input(_event) -> Estado:
	return null

func process(_delta) -> Estado:
	return null

func physics_process(_delta) -> Estado:
	return null

func get_maquina_estados(_nodo):
	pass
