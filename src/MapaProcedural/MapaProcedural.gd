@tool
extends Node3D

@onready var grid_map : GridMap = $GridMap

@export var start : bool = false : set = set_start
func set_start(val:bool)->void:
	generate()

@export var border_size : int = 20 : set = set_border_size
func set_border_size(val : int)->void:
	border_size = val
	if Engine.is_editor_hint():
		visualize_border()

func visualize_border():
	grid_map.clear()
	for i in range(-1, border_size+1):
		#BASE
		grid_map.set_cell_item(Vector3i(i,0,-1),1)
		grid_map.set_cell_item(Vector3i(i,0,border_size),1)
		grid_map.set_cell_item(Vector3i(border_size,0,i),1)
		grid_map.set_cell_item(Vector3i(-1,0,i),0)
		#TECHO
		grid_map.set_cell_item(Vector3i(i,border_size,-1),1)
		grid_map.set_cell_item(Vector3i(i,border_size,border_size),1)
		grid_map.set_cell_item(Vector3i(border_size,border_size,i),1)
		grid_map.set_cell_item(Vector3i(-1,border_size,i),0)
		#LADO 1 
		grid_map.set_cell_item(Vector3i(i,border_size,-1),1)
		grid_map.set_cell_item(Vector3i(i,border_size,border_size),1)
		grid_map.set_cell_item(Vector3i(border_size,border_size,i),1)
		grid_map.set_cell_item(Vector3i(-1,border_size,i),0)
				#LADO 2 
		grid_map.set_cell_item(Vector3i(i,i,-1),1)
		grid_map.set_cell_item(Vector3i(i,i,border_size),1)
		grid_map.set_cell_item(Vector3i(border_size,i,i),1)
		grid_map.set_cell_item(Vector3i(-1,i,i),0)
				#3
		grid_map.set_cell_item(Vector3i(i,i,-1),1)
		grid_map.set_cell_item(Vector3i(i,i,border_size),1)
		grid_map.set_cell_item(Vector3i(border_size,i,i),1)
		grid_map.set_cell_item(Vector3i(-1,i,border_size),0)
				#4
		grid_map.set_cell_item(Vector3i(i,border_size,-1),1)
		grid_map.set_cell_item(Vector3i(i,border_size,border_size),1)
		grid_map.set_cell_item(Vector3i(border_size,border_size,i),1)
		grid_map.set_cell_item(Vector3i(-1,border_size,i),0)
func generate():
	print("generating ...")
