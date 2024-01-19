extends Node3D

@export var dif: float = 20
@onready var padre =  get_parent_node_3d()
@onready var pos_anterior = get_parent_node_3d().global_position

func _process(delta):
	var vel = padre.global_position - pos_anterior
	global_position = padre.global_position + vel * dif
	pos_anterior = padre.global_position
