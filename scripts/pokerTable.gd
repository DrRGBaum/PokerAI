extends Node2D

# hier läuft die game logic
# also rundenablauf usw
@onready var cardStack = $cardStack
var playerHand = []
var currentPlayer = 0
var game = 0 # number of game playing
var gameRound = 0 # current gameRound of the cards
var smallBlind = 0
var minBet = 100

var raised = 0
var canRaise = true
var justRaised = false
var isPlaying = [true, true, true, true, true]
var allBets = []
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

func turn(): # turn logic for one round
	aiPlayer.displayTurn(currentPlayer)
	justRaised = false
	if currentPlayer == 0 + smallBlind and isPlaying[0]:
		labels.enableButtons()
		await button_clicked
		labels.setPlayerBet(betting)
		labels.disableButtons()
	elif isPlaying[currentPlayer]: # ai turn
		await wait(2.5)
		aiPlayer.aiDecision(currentPlayer - 1)
	countBets()

func roundProcess():
	while true:
		await turn() # normal turns
		nextPlayer()

		if gameRound == 0 and currentPlayer == smallBlind:
			await turn() # first round, small last bet or call
			if allBets.min() == currentBet: await next_round()
			else: nextPlayer()
		elif currentPlayer == smallBlind and allBets.min() == currentBet:
			await next_round() # next round if all players have same bet

func lastPlayer():
	currentPlayer -= 1
	if currentPlayer == - 1: currentPlayer = 4

func nextPlayer():
	currentPlayer += 1
	if currentPlayer == 5: currentPlayer = 0

func folds(player: int):
	isPlaying[player] = false
	cardStack.hideCards(player)
	countBets()

func countBets(): # to get easier min and highest bet
	allBets.clear()
	if isPlaying[0]:allBets.append(betting)
	
	for i in range(3):
		if isPlaying[i + 1]:
			allBets.append(aiBettings[i])

func blinds():
	# mindest einsatz setzen für die blinds
	if smallBlind == 0: # small
		betting = minBet * 0.5
		money -= betting
	else:
		var a = smallBlind - 1
		aiBettings[a] = minBet * 0.5
		aiMoney[a] -= minBet * 0.5
	
	var bigBLind = smallBlind + 1
	if bigBLind == 5: bigBLind = 0
	
	if bigBLind == 0: # big
		betting = minBet
		money -= betting
	else:
		var a = bigBLind - 1
		aiBettings[a] = minBet
		aiMoney[a] -= minBet
	currentPlayer = smallBlind + 2
	if currentPlayer == 5: currentPlayer = 0
	if currentPlayer == 5: currentPlayer = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	labels.disableButtons()
	
	allBets = [betting, aiBettings[0],aiBettings[1],aiBettings[2],aiBettings[3]]
	
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
	labels.canRaise = canRaise
	labels.money = money
	labels.minSlider = betting

	aiPlayer.aiMoney = aiMoney
	aiPlayer.currentBet = currentBet
	aiPlayer.aiBettings = aiBettings
	aiPlayer.canRaise = canRaise
	pass

func next_round() -> void:
	var cardStack = $cardStack

	# reset bettings
	pot = betting + aiBettings[0] + aiBettings[1] + aiBettings[2] + aiBettings[3]
	betting = 0

	for i in range(aiBettings.size()):
		aiBettings[i] = 0
		aiPlayer.aiBettings[i] = 0

	labels.setPlayerBet(betting)
	setCurrentBet(0)

	match gameRound:
		0: cardStack.firstRound(); gameRound += 1
		1: cardStack.nextRound(gameRound); gameRound += 1
		2: cardStack.nextRound(gameRound); gameRound += 1
		3: pass # logic for after gameRound
	
	raised = 0
	canRaise = true
	await wait(2.5)

func setCurrentBet(pBet):
	justRaised = true
	raised += 1
	if raised > 2: canRaise = false
	currentBet = pBet
	labels.setCurrentBet(pBet)

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout

func _on_raise_pressed() -> void:
	betting += labels.sliderValue
	money -= labels.sliderValue
	button_clicked.emit()

func _on_call_pressed() -> void:
	betting = currentBet
	money -= currentBet
	button_clicked.emit()

func _on_fold_pressed() -> void:
	folds(0)
	button_clicked.emit()
