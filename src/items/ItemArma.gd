extends ItemInterface
class_name ItemArma

var estadisticas_arma: EstadisticasArma

func init(estadisticas):
	estadisticas_arma = estadisticas.estadisticas_arma

func aplicar():
	push_error("Error ItemArma: Metodo aplicar(objetivo) debe ser implementado")
