extends "res://ServidorSocket.gd"


var lastmove_x = 25
var lastmove_y = 25



var x = 25
var y = 25

#este es pacman
var pacm = [
			[0,0],[1,16],[1,16],[1,16],[0,0],
			[1,15],[1,16],[1,16],[1,16],[1,16],
			[1,15],[1,16],[1,16],[0,0],[0,0],
			[1,15],[1,15],[1,16],[1,16],[1,16],
			[0,0],[1,15],[1,15],[1,16],[0,0]
			]


#este es el mapa con las bolas, lo imprimimos la primera vez
var mapbolas = [
		[6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,11,4,4,4,11,4,4,4,4,4,4,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,11,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,6,6,6,6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,11,4,4,4,6,4,4,4,11,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,11,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,4,11,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,11,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,11,4,4,4,4,4,4,11,4,4,4,4,11,4,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,11,4,4,4,4,4,4,4,4,4,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,11,4,4,4,4,4,4,4,11,4,4,4,4,4,11,4,4,4,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,6,6,6,6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,11,4,11,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,11,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,11,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,11,4,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,]

]

#pantalla cuando se gana algun juego
var win = [
		[6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,11,4,4,4,11,4,4,4,4,4,4,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,11,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,6,6,6,6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,11,4,4,4,6,4,4,4,11,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,11,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,4,11,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,11,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,11,4,4,4,4,4,4,11,4,4,4,4,11,4,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,11,4,4,4,4,4,4,4,4,4,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,11,4,4,4,4,4,4,4,11,4,4,4,4,4,11,4,4,4,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,6,6,6,6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,11,4,11,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,11,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,11,4,4,4,4,6,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,11,4,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,6,6,6,6,6,6,6,6,6,6,6,6,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,6,],
		[6,4,4,4,4,4,6,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,6,4,4,4,4,4,4,4,6,4,4,4,4,4,6,],
		[6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,]

]

func _ready():
	_init()
	socketpantalla.put_var(["pacman",pacm,mapbolas])
	socketpantalla.put_var(["moverse",x,y,11,6])


func _process(_delta):
	if(socket.get_available_packet_count() > 0):
			var data = socket.get_var()

			if(data[0] == "quit"):
				socketpantalla.put_var(["set_fondo",get_parent().default])
				yield(get_tree().create_timer(2), "timeout")
				quit()
			
			#recibir confirmacion de movimiento
			if (data[0] == "colision"):
				arreglar_pos()
				
			#recibir cantidad de puntos 
			if (data[0] == "puntos"):
				if data[1] == []:
					quit()
				
			#recibimos los inputs
			if (data[0] == "arriba"):
				mover_personaje(1)
			elif (data[0] == "abajo"):
				mover_personaje(2)
			elif (data[0] == "izquierda"):
				mover_personaje(3)
			elif (data[0] == "derecha"):
				mover_personaje(4)

			#else:
				#print("Se recibio en la consola: " + data[0])



func mover_personaje(dir):
	if dir ==1:
		lastmove_x = x
		lastmove_y = y
		y -= 1
	elif dir == 2:
		lastmove_x = x
		lastmove_y = y
		y += 1
	elif dir == 3:
		lastmove_x = x
		lastmove_y = y
		x += 1
	elif dir == 4:
		lastmove_x = x
		lastmove_y = y
		x -= 1
	else:
		return
	socketpantalla.put_var(["moverse",x,y,11,6]) #11 color de bolas y 6 de colision


func arreglar_pos():
	x = lastmove_x
	y = lastmove_y
	socketpantalla.put_var(["moverse",x,y,11,6])
	pass
