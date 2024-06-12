extends Node2D

# steuert die ai handlungen
# kümmert sich um anzeigen der AI variabeln und das kolorieren wer gerade drann ist und small und big blind
var aiMoney = [1000,1000,1000,1000]
var aiBettings = [0,0,0,0]
var standardMoney = 1000

@onready var aiMoneten = [$aiMoneten0,$aiMoneten1,$aiMoneten2,$aiMoneten3]
@onready var aiBet = [$bet0,$bet1,$bet2,$bet3]
@onready var aiName = [$aiPlayer0,$aiPlayer1,$aiPlayer2,$aiPlayer3]
@onready var playerName = $'../tableLabels/playerName'

func aiDecision(pAI:int):
	var rand = RandomNumberGenerator.new()
	match rand.randi_range(0,2):
		0:aiRaise(pAI)
		1:aiCall(pAI)
		2:aiFold(pAI)
	#decides what the ai will do, pAI is the current it decides for
	#if aiMoney[pAI] > standardMoney * 0.75:
		#aiRaise(pAI)
	#elif aiMoney[pAI] > standardMoney * 0.25:
		#aiCall(pAI)
	#else:
		#aiFold(pAI)

func aiRaise(pAI:int):
	aiBettings[pAI] = $'../..'.currentBet + standardMoney * 0.1

func aiCall(pAI:int):
	aiBettings[pAI] = $'../..'.currentBet

func aiFold(pAI:int):
	# fold ig
	pass

func _ready() -> void: # sets the variables when node is created
	pass

func displayTurn(pPlayer:int): # turns the outline of the current player black
	
	playerName.add_theme_constant_override('outline_size',0)
	for i in range(4):
		aiName[i].add_theme_constant_override('outline_size',0)
		
	if pPlayer == 0:
		playerName.add_theme_color_override('font_outline_color',Color(0,0,0))
		playerName.add_theme_constant_override('outline_size',10)
	else: 
		pPlayer-=1
		aiName[pPlayer].add_theme_color_override('font_outline_color',Color(0,0,0))
		aiName[pPlayer].add_theme_constant_override('outline_size',10)


func displaySmall(pPlayer:int):# colors names for big and small blind
	playerName.add_theme_color_override('font_color',Color(255,255,255))
	for i in range(4):
		aiName[i].add_theme_color_override('font_color',Color(255,255,255))
		
	if pPlayer == 0:
		playerName.add_theme_color_override('font_color',Color(0,0,255))
	else:
		var a = pPlayer - 1
		aiName[a].add_theme_color_override('font_color',Color(0,0,255))
	
	# place big blind next to small blind
	pPlayer+=1
	if pPlayer == 5: pPlayer=0
		
	if pPlayer == 0:
		playerName.add_theme_color_override('font_color',Color(255,255,0))
	else:
		var a = pPlayer - 1
		aiName[a].add_theme_color_override('font_color',Color(255,255,0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(4):
		aiMoneten[i].set_text("$ " + str(aiMoney[i]))
		if aiBettings[i] != null and aiBettings[i] != 0:
			aiBet[i].set_text("$ " + str(aiBettings[i]))
		else:
			aiBet[i].set_text("")
