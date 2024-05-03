extends Node

@export var objetivo: Node3D = null

@export var enemigo = preload("res://escenas/enemigos/Enemigo_1.tscn")
@export var enfriamiento: float = 5
@export var distancia_maxima: float = 10
@export var vida_maxima: float = 20
var enfriamiento_actual: float = 0

func _ready():
	pass 

func spawn():
	
	if enfriamiento_actual > 0:
		return
	enfriamiento_actual = enfriamiento
	var b = enemigo.instantiate()
	b.objetivo = objetivo
	b.vida = vida_maxima
	add_child(b)

func _process(delta):
	enfriamiento_actual -= delta
	if objetivo.global_position.distance_to(self.global_position) > distancia_maxima:
		return
	else:
		spawn()
