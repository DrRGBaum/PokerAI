extends Node2D

# var stack = array of cards in random order
# var tableCards = array cards pos left to right
# shuffel() function to randomize the order of the cards

var cardScene = preload("res://scenes/card.tscn")

var stack = []
var playerHand = []

var tableCards = [Vector2(300,200),Vector2(390,200),Vector2(480,200),Vector2(570,200),Vector2(660,200)]
var hand = [Vector2(621,470),Vector2(706,470)]

func deal(): #karten austeilen
	playerHand = [stack[0], stack[1]]
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
			instance.region_pos = Rect2(40*j,60*i,40,60)
			instance.set_position(tableCards[4])
			stack.append(instance)
			add_child(instance)
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
