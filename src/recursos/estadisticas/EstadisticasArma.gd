extends Resource
class_name EstadisticasArma

@export var enfriamiento: float = 1
@export var dispersion_x: float = 1
@export var dispersion_y: float = 1
@export var dispersion_z: float = 1
# 0 - Disparo de proyectil    1 - Disparo laser
@export var tipo_disparo: int = 0
@export var cant_disparos: float = 1
@export var daño_disparo: float

var efectos_disparo: Array[EfectoDisparo] = []
var enfriamiento_actual: float = 0
