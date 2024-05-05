extends Node
class_name MaquinaDeEstados

@export var estado_inicial:= NodePath()
@onready var estado_actual: Estado = get_node(estado_inicial)

func init(objetivo_control, objetivo_animaciones):
	for nodo in get_children():
		nodo.objetivo = objetivo_control
		nodo.animaciones = objetivo_animaciones

func transicion(proximo_estado: Estado):
	if estado_actual:
		estado_actual.salir()
	estado_actual = proximo_estado
	proximo_estado.entrar()

func input(event):
	var proximo_estado = estado_actual.input(event)
	if proximo_estado:
		transicion(proximo_estado)

func process(delta):
	var proximo_estado = estado_actual.process(delta)
	if proximo_estado:
		transicion(proximo_estado)

func physics_process(delta):
	var proximo_estado = estado_actual.physics_process(delta)
	if proximo_estado:
		transicion(proximo_estado)


