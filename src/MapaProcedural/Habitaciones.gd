extends Node
class_name Habitacion

# Definición de la clase Room
#class Habitacion:
var borde: AABB

func _init(location: Vector3i, size: Vector3i) -> void:
	borde = AABB(location, size)


static func intersect(a: Habitacion, b: Habitacion) -> bool:
	return !((a.borde.position.x >= (b.borde.position.x + b.borde.size.x)) or ((a.borde.position.x + a.borde.size.x) <= b.borde.position.x)
			or (a.borde.position.y >= (b.borde.position.y + b.borde.size.y)) or ((a.borde.position.y + a.borde.size.y) <= b.borde.position.y)
			or (a.borde.position.z >= (b.borde.position.z + b.borde.size.z)) or ((a.borde.position.z + a.borde.size.z) <= b.borde.position.z))

# Creación de dos instancias de Room
var habA := Habitacion.new(Vector3i(0, 0, 0), Vector3i(5, 5, 5))
var habB := Habitacion.new(Vector3i(3, 3, 3), Vector3i(5, 5, 5))

# Comprobación de intersección entre las dos habitaciones
var intersecting := Habitacion.intersect(habA, habB)
