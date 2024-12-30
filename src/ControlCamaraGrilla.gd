extends Node
@onready var controles = get_node("/root/InputController")
@onready var camara: CamaraControl = $".."

var pos_actual: Vector3

func _input(event):
	pos_actual = camara.global_position
	if controles.capturando:
		if Input.is_action_just_pressed("atras"):
			camara.global_position = pos_actual + Vector3(0,0,1)
		if Input.is_action_just_pressed("adelante"):
			camara.global_position = pos_actual + Vector3(0,0,-1)
		if Input.is_action_just_pressed("derecha"):
			camara.global_position = pos_actual + Vector3(1,0,0)
		if Input.is_action_just_pressed("izquierda"):
			camara.global_position = pos_actual + Vector3(-1,0,0)
		if Input.is_action_just_pressed("salto"):
			camara.global_position = pos_actual + Vector3(0,1,0)
		if Input.is_action_just_pressed("agacharse"):
			camara.global_position = pos_actual + Vector3(0,-1,0)
