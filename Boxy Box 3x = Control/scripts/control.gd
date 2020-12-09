extends Node2D



var botones = []

func _ready():
	add_botones()
	for boton in botones:
		boton.connect("presionado",self,"boton_presionado")
		boton.connect("soltado",self,"boton_soltado")
		
		set_network_master(get_tree().get_network_unique_id())
	pass


func add_botones():
	botones = [
		get_node("abajo"),
		get_node("arriba"),
		get_node("izquierda"),
		get_node("derecha"),
		
		get_node("rojo"),
	]
	pass

func boton_presionado(accion):
	print("Se ha presionado el boton > ",accion)
	rpc_unreliable("boton_presionado_network", accion)
	pass

func boton_soltado(accion):
	print("Se ha soltado el boton > ",accion)
	rpc_unreliable("boton_soltado_network", accion)
	pass
