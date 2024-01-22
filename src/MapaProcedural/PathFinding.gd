extends Reference #Mas amplio que un simple nodo.

class Node: # Se crea la clase nodo que será utilizada posteriormente
	var position
	var previous
	var previous_set
	var costo

	func _init(position):
		self.position = position
		self.previous_set = []
		self.previous = null
		self.cost = float.INFINITY

class DungeonPathfinder3D:
	var grid
	var queue
	var closed
	var stack
	const neighbors = [
		Vector3(1, 0, 0),
		Vector3(-1, 0, 0),
		Vector3(0, 0, 1),
		Vector3(0, 0, -1),

		Vector3(3, 1, 0),
		Vector3(-3, 1, 0),
		Vector3(0, 1, 3),
		Vector3(0, 1, -3),

		Vector3(3, -1, 0),
		Vector3(-3, -1, 0),
		Vector3(0, -1, 3),
		Vector3(0, -1, -3)
	]

	func _init(size):
		grid = {}
		queue = []
		closed = []
		stack = []
		
		for x in range(size.x):
			for y in range(size.y):
				for z in range(size.z):
					grid[x, y, z] = Node.new(Vector3i(x, y, z))

	func reset_nodes():
		for node in grid.values():
			node.previous = null
			node.cost = float.INFINITY
			node.previous_set = []

	func find_path(start, end, cost_function):
		reset_nodes()
		queue.clear()
		closed.clear()
		stack.clear()

		grid[start].cost = 0
		queue.append(grid[start])

		while queue.size() > 0:
			var node = queue.pop_back()
			closed.append(node)

			if node.position == end:
				return reconstruct_path(node)

			for offset in neighbors:
				var neighbor_position = node.position + offset
				if not grid.has(neighbor_position):
					continue

				var neighbor = grid[neighbor_position]

				if closed.has(neighbor):
					continue

				if node.previous_set.has(neighbor.position):
					continue

				var path_cost = cost_function(node, neighbor)

				if not path_cost.traversable:
					continue

				if path_cost.is_stairs:
					var x_dir = clamp(offset.x, -1, 1)
					var z_dir = clamp(offset.z, -1, 1)
					var vertical_offset = Vector3(0, offset.y, 0)
					var horizontal_offset = Vector3(x_dir, 0, z_dir)

					if node.previous_set.has(node.position + horizontal_offset) or
					   node.previous_set.has(node.position + horizontal_offset * 2) or
					   node.previous_set.has(node.position + vertical_offset + horizontal_offset) or
					   node.previous_set.has(node.position + vertical_offset + horizontal_offset * 2):
						continue

				var new_cost = node.cost + path_cost.cost

				if new_cost < neighbor.cost:
					neighbor.previous = node
					neighbor.cost = new_cost

					if queue.has(node):
						queue.erase(node)
					queue.append(neighbor)

					neighbor.previous_set = node.previous_set
					neighbor.previous_set.append(node.position)

					if path_cost.is_stairs:
						var x_dir = clamp(offset.x, -1, 1)
						var z_dir = clamp(offset.z, -1, 1)
						var vertical_offset = Vector3(0, offset.y, 0)
						var horizontal_offset = Vector3(x_dir, 0, z_dir)

						neighbor.previous_set.append(node.position + horizontal_offset)
						neighbor.previous_set.append(node.position + horizontal_offset * 2)
						neighbor.previous_set.append(node.position + vertical_offset + horizontal_offset)
						neighbor.previous_set.append(node.position + vertical_offset + horizontal_offset * 2)

		return null

	func reconstruct_path(node):
		var result = []

		while node != null:
			stack.append(node.position)
			node = node.previous

		while stack.size() > 0:
			result.append(stack.pop_back())

		return result
