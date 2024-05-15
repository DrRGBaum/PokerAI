extends Node2D

# var stack = array of cards in random order
# var positions = array cards pos left to right
# shuffel() function to randomize the order of the cards

var cardScene = preload("res://scenes/card.tscn")

var stack = []

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
			instance.set_position(Vector2(90 * j + 40,130*i + 60))
			stack.append(instance)
			add_child(instance)
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
