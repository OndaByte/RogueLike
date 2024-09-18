extends Node
class_name MaquinaDeEstados

@export var estado_inicial: Estado 
@export var estado_actual: Estado

func init(objetivo_control: Object, objetivo_animaciones: AnimationMixer) -> void:
	for nodo in get_children():
		nodo.objetivo = objetivo_control
		nodo.animaciones = objetivo_animaciones

func transicion(proximo_estado: Estado) -> void:
	if estado_actual:
		estado_actual.salir()
	estado_actual = proximo_estado
	estado_actual.entrar()

func input()  -> void:
	var proximo_estado = estado_actual.input()
	if proximo_estado:
		transicion(proximo_estado)

func process(delta: float)  -> void:
	var proximo_estado = estado_actual.process(delta)
	if proximo_estado:
		transicion(proximo_estado)

func physics_process(delta: float)  -> void:
	var proximo_estado = estado_actual.physics_process(delta)
	if proximo_estado:
		transicion(proximo_estado)
