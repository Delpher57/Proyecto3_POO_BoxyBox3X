extends Button

#4242 es el adress para hablarle a la consola
#5252 es el adress para hablarle a la pantalla
var socket
var juego = preload ("res://PacmanConsola.tscn")
var click

func _ready():
	print ("consola")
	_init()




func _init():
  socket = PacketPeerUDP.new()
  socket.set_dest_address("127.0.0.1",5252)





func _on_Pacman_pressed():
	print ("Empezando pacman...")
	var juegopacman = juego.instance()
	get_parent().add_child(juegopacman)
	
