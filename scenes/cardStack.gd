extends Node2D

# var stack = array of cards in random order
# var positions = array cards pos left to right
# shuffel() function to randomize the order of the cards

var cardScene = preload("res://scenes/card.tscn")

var stack = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(13):
		var instance = cardScene.instantiate()
		instance.pos = Rect2(40*i,0,40,60)
		instance.set_position(Vector2(50 * i + 50,200))
		stack.append(instance)
		add_child(stack[i])
	queue_redraw()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
