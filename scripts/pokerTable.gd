extends Node2D

# hier läuft die game logic
# also rundenablauf usw

var playerHand = []
var currentPlayer = 0
var game = 0 # number of game playing
var round = 0 # current round of the cards
var minBet = 100

# table vars
var pot
var currentBet = 0

# player vars
@onready var labels = $UI/tableLabels
var betting
var money = 1000

# ai vars
@onready var aiPlayer = $UI/aiPlayer
var aiMoney = [1000, 1000, 1000, 1000]
var aiBettings = [0, 0, 0, 0]

func roundProcess(): # TODO get done
	var a = currentPlayer - 1
	while (a <= 3):
		$UI/aiPlayer.aiDecision(a)
		$UI/aiPlayer.displayTurn(a + 1)
		await wait(2)
		a += 1
		pass
	# turn of each AI and next turn
	pass

func blinds():
	# mindest einsatz setzen für die blinds
	if game == 0: # small
		betting = minBet * 0.5
	else:
		var a = game - 1
		aiBettings[a] = minBet * 0.5
	
	game += 1
	if game == 5: game = 0
	
	if game == 0: # big
		betting = minBet * 0.5
	else:
		var a = game - 1
		aiBettings[a] = minBet * 0.5
	currentPlayer = game + 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var cardStack = $cardStack
	
	cardStack.deal()
	
	$UI/aiPlayer.displayTurn(currentPlayer)
	
	$UI/aiPlayer.displaySmall(round)
	
	blinds()
	
	roundProcess()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# constantly update the variables in the classes in which they get displayed
	labels.betting = betting
	labels.money = money
	
	currentBet = max(betting, aiBettings[0], aiBettings[1], aiBettings[2], aiBettings[3]) # might not work on whole array
	labels.currentBet = currentBet
	labels.tablePot = pot

	aiPlayer.aiMoney = aiMoney
	aiPlayer.currentBet = currentBet
	aiPlayer.aiBettings = aiBettings
	pass

func _on_next_round_pressed() -> void:
	var cardStack = $cardStack
	match round:
		0: cardStack.firstRound(); round += 1
		1: cardStack.nextRound(round); round += 1
		2: cardStack.nextRound(round); round += 1
		3: pass # logic for after round
	pass # Replace with function body.

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout

func _on_raise_pressed() -> void:
	pass # Replace with function body.

func _on_call_pressed() -> void:
	pass # Replace with function body.

func _on_fold_pressed() -> void:
	pass # Replace with function body.
