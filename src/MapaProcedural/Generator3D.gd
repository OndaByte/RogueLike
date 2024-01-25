@tool
extends Node3D  
@onready var grid_map : GridMap = $GridMap #va a ejecutar cuando este ready
#@export var start : bool = false : set = set_start


# ESto lo copie del script
enum CellType {
	NONE,
	ROOM,
	HALLWAY,
	STAIRS
}

var size : Vector3 = Vector3(10, 10, 10)
var room_count : int = 5
var room_max_size : Vector3 = Vector3(5, 5, 5)
var cube_prefab : PackedScene
var red_material : Material
var blue_material : Material
var green_material : Material


var random : Random
var grid : Grid3D
var rooms : Array
var delaunay : Delaunay3D
var selected_edges : Set

func _ready():
	random = Random.new()
	grid = Grid3D.new()
	rooms = []
	delaunay = Delaunay3D.new()
	selected_edges = Set()
