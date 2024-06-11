extends Node2D

# var stack = array of cards in random order
# var tableCards = array cards pos left to right
# shuffel() function to randomize the order of the cards

var cardScene = preload("res://scenes/card.tscn")

var stack = []
var table = []
var playerHand = []
var aiPlayer0 = [] # lowkey ineffizient
var aiPlayer1 = [] # problem für später tbh
var aiPlayer2 = []
var aiPlayer3 = []

# hintergrund pixelgröße: 480, 270
# karten größe 40, 60
# alle pixelgrößen mal 2 da zwei facher faktor
var tablePos = [Vector2(300,200),Vector2(390,200),Vector2(480,200),Vector2(570,200),Vector2(660,200)]
var handPos = [Vector2(621,470),Vector2(706,470)]

func firstRound():
	for i in range(3):
		stack[10 + i].set_position(tablePos[i])
		table.append(stack[10 + i])
	pass

func nextRound(round :int):
	stack[12 + round].set_position(tablePos[2 + round])
	table.append(stack[12 + round])
	pass

func placeCards():
	for i in range(2):
		playerHand[i].set_position(handPos[i])
		playerHand[i].setGlow(true)
		aiPlayer0[i].set_position(Vector2(70 + (i * 40),310))
		aiPlayer1[i].set_position(Vector2(70 + (i * 40),90))
		aiPlayer2[i].set_position(Vector2(850 + (i * 40),90))
		aiPlayer3[i].set_position(Vector2(850 + (i * 40),310))
		
		aiPlayer0[i].visible(false)
		aiPlayer1[i].visible(false)
		aiPlayer2[i].visible(false)
		aiPlayer3[i].visible(false)
		
		aiPlayer0[i].set_z_index(i)
		aiPlayer1[i].set_z_index(i)
		aiPlayer2[i].set_z_index(i)
		aiPlayer3[i].set_z_index(i)
	
	for i in range (42): # restliche karten verstecken
		stack[10 + i].set_position(Vector2(-40,200))
	
	queue_redraw()
	pass

func deal(): #karten austeilen, legit altmodisch wie irl karten austeilen
	shuffelCards()
	playerHand = [stack[0], stack[1]]
	
	aiPlayer0 = [stack[2], stack[3]]
	aiPlayer1 = [stack[4], stack[5]]
	aiPlayer2 = [stack[6], stack[7]]
	aiPlayer3 = [stack[8], stack[9]]
	placeCards()
	pass

func shuffelCards(): # mischt die karten
	randomize()
	stack.shuffle()
	pass

func display(): #displays card deck in current order
	for i in range(52):
		stack[i].set_position(Vector2(20 * i + 40,200))
		stack[i].set_z_index(i)
		queue_redraw()
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready(): # erstellt einen kartenstapel mit den kartenobjekten
	for i in range(4):
		for j in range(13):
			var instance = cardScene.instantiate()
			instance.regionPos = Rect2(40*j,60*i,40,60)
			instance.set_position(tablePos[4])
			instance.number = j
			match i: # spades, hearts, clubs, diamonds
				0: instance.color = "s"
				1: instance.color = "h"
				2: instance.color = "c"
				3: instance.color = "d"
			stack.append(instance)
			add_child(instance)
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var flip = true
func _on_button_pressed() -> void:
	flip = !flip
	for i in range(2):
		aiPlayer0[i].visible(flip)
		aiPlayer1[i].visible(flip)
		aiPlayer2[i].visible(flip)
		aiPlayer3[i].visible(flip)
	pass # Replace with function body.
