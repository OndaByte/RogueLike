extends Node3D
class_name Disparo

@export var daño: int = 10
@export var magnitud: float = 500
@export var efectos_disparo: Array[EfectoDisparo] = []

func init():
	push_error("Error Disparo: Metodo init() debe ser implementado")

func golpeando(_target):
	push_error("Error Disparo: Metodo golpeando(target) debe ser implementado")

func golpeando_posicion():
	push_error("Error Disparo: Metodo golpeando_posicion() debe ser implementado")

func nueva_instancia():
	push_error("Error Disparo: Metodo nueva_instancia() debe ser implementado")
