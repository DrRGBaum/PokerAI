extends Node2D

# hier läuft die game logic
# also rundenablauf usw

var playerHand = []
var currentPlayer = 0
var round = 0
var minBet = 100

# table vars
var pot
var currentBet

# player vars
var betting
var money = 1000

# ai vars
var aiMoney = [1000,1000,1000,1000]
var aiBettings = [0,0,0,0]

func roundProcess():
	# turn of each AI and next turn
	pass

func blinds():
	# mindest einsatz setzen für die blinds
	if round == 0:
		betting = minBet * 0.5
	else:
		var a = round - 1
		aiBettings[a] = minBet * 0.5
	
	round += 1
	if round == 5: round = 0
	
	if round == 0:
		betting = minBet * 0.5
	else:
		var a = round - 1
		aiBettings[a] = minBet * 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	var cardStack = $cardStack
	# cardStack.shuffelCards()
	# cardStack.display()
	cardStack.deal()
	$UI/aiPlayer.displayTurn(currentPlayer)
	
	# $UI/aiPlayer.displayBig(1)
	$UI/aiPlayer.displaySmall(round)
	
	blinds()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI/tableLabels.betting = betting
	$UI/tableLabels.money = money
	
	currentBet = max(betting,aiBettings[0],aiBettings[1],aiBettings[2],aiBettings[3]) # might not work on whole array
	$UI/tableLabels.currentBet = currentBet

	wait(1)
	pass


func _on_next_round_pressed() -> void:
	var cardStack = $cardStack
	match round:
		0: cardStack.firstRound(); round += 1
		1: cardStack.nextRound(round); round += 1
		2: cardStack.nextRound(round); round += 1
		3: pass #logic for after round
	pass # Replace with function body.

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout

func _on_raise_pressed() -> void:
	pass # Replace with function body.


func _on_call_pressed() -> void:
	pass # Replace with function body.


func _on_fold_pressed() -> void:
	pass # Replace with function body.
