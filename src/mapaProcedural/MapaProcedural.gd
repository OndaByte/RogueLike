@tool
extends Node3D
@export var grid_map: GridMap
@export var Generar : bool = false : set = generar

@export var peso_minimo: float = 0.02
@export var z_max : int = 40
@export var y_max : int = 40
@export var x_max : int = 40
@export var noise : FastNoiseLite
@export var can_habitaciones: int = 7

var mutex: Mutex

func generar(val:bool)->void:
	generar_mapa()

func generar_mapa():
	grid_map.clear()
	noise.seed = RandomNumberGenerator.new().randi_range(-100000,100000)
	var z_aux: int = 0
	var y_aux: int = 0
	var x_aux: int = 0
	var threads = []	
	var num_threads = 4
	var step = ceil(z_max/num_threads)
	mutex = Mutex.new()
	
	for i in range(num_threads):
		var start_z = i * step
		var end_z = min((i + 1) * step, z_max)
		var thread = Thread.new()
		thread
		threads.append(thread)
		thread.start(_noise_celda.bind([start_z, end_z, x_max, y_max]))
	
	for thread in threads:
		thread.wait_to_finish()

func _noise_celda(args):
	var start_z = args[0]
	var end_z = args[1]
	var x_actual = args[2]
	var y_actual = args[3]

	for z in range(start_z, end_z):
		for y in range(y_actual):
			for x in range(x_actual):
				if noise.get_noise_3d(x, y, z) > peso_minimo:
					mutex.lock()
					grid_map.set_cell_item.call_deferred(Vector3i(x, y, z), 2)					
					mutex.unlock()
