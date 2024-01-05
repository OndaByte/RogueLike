@tool
extends Node3D

@onready var grid_map : GridMap = $GridMap

@export var start : bool = false : set = set_start
func set_start(val:bool)->void:
	set_border_size()

@export var z_max : int = 40
@export var y_max : int = 40
@export var x_max : int = 40

@export var can_habitaciones: int = 7

var z_actual: int = 0
var y_actual: int = 0
var x_actual: int = 0


func set_border_size()->void:
	z_actual=randi() % z_max
	y_actual=randi() % y_max
	x_actual=randi() % x_max
	if Engine.is_editor_hint():
		visualize_border()

func generar_habitaciones():
	var i: int = 0
	var z_aux: int = 0
	var y_aux: int = 0
	var x_aux: int = 0
	while(can_habitaciones>i):
		while (grid_map.get_cell_item(Vector3(x_aux,y_aux,z_aux)) != grid_map.INVALID_CELL_ITEM):
			z_aux = randi() % z_actual
			y_aux = randi() % y_actual
			x_aux = randi() % x_actual
		i+=1
		grid_map.set_cell_item(Vector3i(x_aux,y_aux,z_aux),0)

func visualize_border():
	grid_map.clear()
	for i in range(0,z_actual+1):
		grid_map.set_cell_item(Vector3i(0,0,i),1)
		grid_map.set_cell_item(Vector3i(x_actual,0,i),1)
		grid_map.set_cell_item(Vector3i(0,y_actual,i),1)
		grid_map.set_cell_item(Vector3i(x_actual,y_actual,i),1)
		for t in range(1,x_actual):
			grid_map.set_cell_item(Vector3i(t,0,i),1)
			grid_map.set_cell_item(Vector3i(t,y_actual,0),1)
			grid_map.set_cell_item(Vector3i(t,y_actual,z_actual),1)
	for i in range(1,y_actual):
		grid_map.set_cell_item(Vector3i(0,i,0),1)
		grid_map.set_cell_item(Vector3i(0,i,z_actual),1)
		grid_map.set_cell_item(Vector3i(x_actual,i,0),1)
		grid_map.set_cell_item(Vector3i(x_actual,i,z_actual),1)
	generar_habitaciones()
