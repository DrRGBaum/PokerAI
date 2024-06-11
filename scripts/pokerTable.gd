extends Node2D

# hier läuft die game logic
# also rundenablauf usw

var playerHand = []
var currentPlayer = 0
var round = 0
var minBet = 100

func turn(pTurn):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	var cardStack = $cardStack
	# cardStack.shuffelCards()
	# cardStack.display()
	cardStack.deal()
	$UI/aiPlayer.displayTurn(0)
	
	# $UI/aiPlayer.displayBig(1)
	$UI/aiPlayer.displaySmall(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_next_round_pressed() -> void:
	var cardStack = $cardStack
	match round:
		0: cardStack.firstRound(); round += 1
		1: cardStack.nextRound(round); round += 1
		2: cardStack.nextRound(round); round += 1
		3: pass #logic for after round
	pass # Replace with function body.


func _on_raise_pressed() -> void:
	pass # Replace with function body.


func _on_call_pressed() -> void:
	pass # Replace with function body.


func _on_fold_pressed() -> void:
	pass # Replace with function body.
