extends Node2D

# hier läuft die game logic
# also rundenablauf usw

var playerHand = []
var currentPlayer = 0
var game = 0 # number of game playing
var gameRound = 0 # current gameRound of the cards
var smallBlind = 0
var minBet = 100

var players = []
# table vars
var pot = 0
var currentBet = 0

# player vars
@onready var labels = $UI/tableLabels
var betting
var money = 1000
var folded = false

# ai vars
@onready var aiPlayer = $UI/aiPlayer
var aiMoney = [1000, 1000, 1000, 1000]
var aiBettings = [0, 0, 0, 0]

signal button_clicked

func roundProcess(): # TODO implement folding
	while true:
		aiPlayer.displayTurn(currentPlayer)
		if currentPlayer == 0 + smallBlind:
			await button_clicked
		else: # ai turn
			await wait(2.5)
			aiPlayer.aiDecision(currentPlayer - 1)
		
		currentPlayer += 1
		if currentPlayer == 5: currentPlayer = 0

		if currentPlayer == smallBlind:
			next_round()
			await wait(2.5)

func blinds():
	# mindest einsatz setzen für die blinds
	if smallBlind == 0: # small
		betting = minBet * 0.5
	else:
		var a = smallBlind - 1
		aiBettings[a] = minBet * 0.5
	
	var bigBLind = smallBlind + 1
	if bigBLind == 5: bigBLind = 0
	
	if bigBLind == 0: # big
		betting = minBet
	else:
		var a = bigBLind - 1
		aiBettings[a] = minBet
	currentPlayer = smallBlind + 2
	if currentPlayer == 5: currentPlayer = 0
	if currentPlayer == 5: currentPlayer = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var cardStack = $cardStack
	
	cardStack.deal()
	
	aiPlayer.displaySmall(gameRound)
	
	blinds()
	labels.setPlayerBet(betting)
	
	roundProcess()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# constantly update the variables in the classes in which they get displayed
	labels.money = money
	
	if max(betting, aiBettings[0], aiBettings[1], aiBettings[2], aiBettings[3]) > currentBet:
		setCurrentBet(max(betting, aiBettings[0], aiBettings[1], aiBettings[2], aiBettings[3]))
	
	labels.tablePot = pot
	labels.currentBet = currentBet

	aiPlayer.aiMoney = aiMoney
	aiPlayer.currentBet = currentBet
	aiPlayer.aiBettings = aiBettings
	pass

func next_round() -> void:
	var cardStack = $cardStack
	match gameRound:
		0: cardStack.firstRound(); gameRound += 1
		1: cardStack.nextRound(gameRound); gameRound += 1
		2: cardStack.nextRound(gameRound); gameRound += 1
		3: pass # logic for after gameRound
	pass # Replace with function body.

func setCurrentBet(pBet):
	currentBet = pBet
	labels.setCurrentBet(pBet)

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout

# TODO consequenzes from buttons
func _on_raise_pressed() -> void: 
	betting = labels.betting
	labels.setPlayerBet(betting)
	button_clicked.emit()
	pass # Replace with function body.

func _on_call_pressed() -> void:
	button_clicked.emit()
	pass # Replace with function body.

func _on_fold_pressed() -> void:
	button_clicked.emit()
	pass # Replace with function body.
