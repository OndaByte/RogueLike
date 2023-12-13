extends Control

@onready var label = $Label
@onready var jugador = $"../../Jugador"

func _process(delta):
	var jug_pos = jugador.global_position
	var jug_vel = jugador._vel
	label.text = "Pos: (%.2f,%.2f,%.2f)\n" % [jug_pos.x,jug_pos.y,jug_pos.z]
	label.text += "Dir: (%.2f,%.2f)\n" % [jugador._mov_dir.x, jugador._mov_dir.y]
	label.text += "Salto: %s\n" % [jugador._salto]
	label.text += "Vel: (%.2f,%.2f,%.2f)\n" % [jug_vel.x,jug_vel.y,jug_vel.z]
	label.text += "Rot: %.2f\n" % [jugador._rotacion]
	label.text += "Saltos: %.2f\n" % [jugador._cont_saltos]
	label.text += "Enfriamiento: %.3f\n" % [jugador._salto_enfriamiento]
	label.text += "Cam Rot (%.3f,%.3f)\n" % [jugador.camara._rot_v,jugador.camara._rot_h]
