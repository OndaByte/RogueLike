@tool
extends Node3D  
@onready var grid_map : GridMap = $GridMap #va a ejecutar cuando este ready
@export var Generar : bool = false : set = generar

func generar(val:bool)->void:
	set_limite()
@export var z_max : int = 40
@export var y_max : int = 40
@export var x_max : int = 40

@export var can_habitaciones: int = 7

var z_actual: int = 0
var y_actual: int = 0
var x_actual: int = 0

# Step 1 / Place rooms 
# Step 2 / Create dlunay tetrahedralization
# Step 3 / Find Minimum Spanning Tree
# Step 4 / Chose Random edges
# Step 5 / Pathfind hallways


func set_limite()->void:
	z_actual=randi() % z_max
	y_actual=randi() % y_max
	x_actual=randi() % x_max
	if Engine.is_editor_hint():
		generar_mapa()

func generar_habitaciones():
	var i: int = 0
	while(can_habitaciones>i):
		random_tile(0)
		i+=1

func random_tile(i:int):
	var z_aux: int = 0
	var y_aux: int = 0
	var x_aux: int = 0
	while (grid_map.get_cell_item(Vector3(x_aux,y_aux,z_aux)) != grid_map.INVALID_CELL_ITEM):
		z_aux = randi() % z_actual
		y_aux = randi() % y_actual
		x_aux = randi() % x_actual
	grid_map.set_cell_item(Vector3i(x_aux,y_aux,z_aux),i)

func generar_mapa():
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
