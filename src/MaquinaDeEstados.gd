extends Node
class_name MaquinaDeEstados

@export var estado_inicial:= NodePath()
@onready var _estado: Estado = get_node(estado_inicial)

func init(objetivo_control):
	for nodo in get_children():
		nodo.objetivo = objetivo_control

func transicion(proximo_estado: Estado):
	if _estado:
		_estado.salir()
	_estado = proximo_estado
	proximo_estado.entrar()

func _input(event):
	var proximo_estado = _estado.input(event)
	if proximo_estado:
		transicion(proximo_estado)

func _process(delta):
	var proximo_estado = _estado.process(delta)
	if proximo_estado:
		transicion(proximo_estado)

func _physics_process(delta):
	var proximo_estado = _estado.physics_process(delta)
	if proximo_estado:
		transicion(proximo_estado)


