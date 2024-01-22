class Grid3D:

	var data : Array
	var size : Vector3
	var offset : Vector3

	# Define the Size property
#  setget _get_size

	func _get_size():
		return size

	func _set_size(value):
		size = value

	func _init(size, offset):
		size = size
		offset = offset
		data = PackedVector3Array(size.x * size.y * size.z)

	func get_index(pos):
		return pos.x + (size.x * pos.y) + (size.x * size.y * pos.z)

	func in_bounds(pos):
		return AABB(Vector3.ZERO, size).has_point(pos + offset)
'''
	func get_cell(x, y, z):
		return get_cell(Vector3(x, y, z))

	func set_cell(x, y, z, value):
		set_cell(Vector3(x, y, z), value)
 
	func get_cell(pos):
		pos += offset
		return data[get_index(pos)]

	func set_cell(pos, value):
		pos += offset
		data[get_index(pos)] = value
'''
