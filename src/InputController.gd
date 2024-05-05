extends Node

var movimiento: Vector2 = Vector2.ZERO
var mouse_posicion: Vector2 = Vector2.ZERO
var impulso: bool = false
var salto: bool = false
var capturando:bool = true
var disparando:bool = false
var disparando2:bool = false

func _input(event):
	movimiento = Input.get_vector("izquierda", "derecha", "adelante", "atras").normalized()
	
	if event is InputEventMouseMotion:
			mouse_posicion = event.relative
	
	if Input.is_action_just_pressed("menu"):
		capturando = !capturando
		if capturando:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if Input.is_action_just_pressed("disparar"):
		disparando = true
	if Input.is_action_just_released("disparar"):
		disparando = false
	
	if Input.is_action_just_pressed("disparar_2"):
		disparando2 = true
	if Input.is_action_just_released("disparar_2"):
		disparando2 = false
	
	impulso = Input.is_action_just_pressed("impulso")
	salto = Input.is_action_just_pressed("salto")
