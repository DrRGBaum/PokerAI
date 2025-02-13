extends Node2D

# var stack = array of cards in random order
# var tableCards = array cards pos left to right
# shuffel() function to randomize the order of the cards

var cardScene = preload ("res://scenes/card.tscn")
@onready var win = $'../PokerTableV0_5'

var stack = []
var table = []
var hide = Vector2(480, -60)

var playerHand = []
var aiPlayer0 = [] # lowkey ineffizient
var aiPlayer1 = [] # problem für später tbh
var aiPlayer2 = []
var aiPlayer3 = []
var pruefe = []

# hintergrund pixelgröße: 480, 270
# karten größe 40, 60
# alle pixelgrößen mal 2 da zwei facher faktor
var tablePos = [Vector2(300, 200), Vector2(390, 200), Vector2(480, 200), Vector2(570, 200), Vector2(660, 200)]
var handPos = [Vector2(621, 470), Vector2(706, 470)]

var animationQue = []

func markCards():
	pruefe = playerHand + table

	for i in range(pruefe.size()):
		pruefe[i].setGlow(false)

	var leuchten
	
	leuchten = win.check(pruefe)
	
	for i in range(leuchten.size()):
		leuchten[i].setGlow(true)

func hideCards(player: int):
	var makeInvis
	match player:
		0: makeInvis = playerHand
		1: makeInvis = aiPlayer0
		2: makeInvis = aiPlayer1
		3: makeInvis = aiPlayer2
		4: makeInvis = aiPlayer3
	makeInvis[0].visible = false
	makeInvis[1].visible = false

func firstRound():
	for i in range(3):
		# stack[10 + i].set_position(tablePos[i])
		animPos(stack[10 + i], tablePos[i], i * 0.1)
		table.append(stack[10 + i])

func nextRound(round: int):
	animPos(stack[12 + round], tablePos[2 + round], 0)
	# var tween = get_tree().create_tween()
	# tween.tween_property(stack[12 + round],"position",tablePos[2 + round], 0.3).set_trans(Tween.TRANS_QUINT)
	# stack[12 + round].set_position(tablePos[2 + round])
	table.append(stack[12 + round])

func placeCards():
	for i in range(2):
		animPos(playerHand[i], handPos[i], i * 0.9)
		
		animPos(aiPlayer0[i], Vector2(70 + (i * 40), 310), i * 0.4 + 0.1)
		animPos(aiPlayer1[i], Vector2(70 + (i * 40), 90), i * 0.4 + 0.2)
		animPos(aiPlayer2[i], Vector2(850 + (i * 40), 90), i * 0.4 + 0.3)
		animPos(aiPlayer3[i], Vector2(850 + (i * 40), 310), i * 0.4 + 0.4)
		
		toggleCards(false)
		
		aiPlayer0[i].set_z_index(i)
		aiPlayer1[i].set_z_index(i)
		aiPlayer2[i].set_z_index(i)
		aiPlayer3[i].set_z_index(i)
		
	for i in range(42): # restliche karten verstecken
		stack[10 + i].set_position(Vector2(480, -60))
	
	queue_redraw()

func toggleCards(see: bool):
	for i in range(2):
		aiPlayer0[i].visible(see)
		aiPlayer1[i].visible(see)
		aiPlayer2[i].visible(see)
		aiPlayer3[i].visible(see)

func deal(): # karten austeilen, legit altmodisch wie irl karten austeilen
	shuffelCards()
	playerHand = [stack[0],stack[1]]
	
	aiPlayer0 = [stack[2],stack[3]]
	aiPlayer1 = [stack[4],stack[5]]
	aiPlayer2 = [stack[6],stack[7]]
	aiPlayer3 = [stack[8],stack[9]]
	placeCards()
	pass

func shuffelCards(): # mischt die karten
	randomize()
	stack.shuffle()
	pass

func display(): # displays card deck in current order
	for i in range(52):
		stack[i].set_position(Vector2(20 * i + 40, 200))
		stack[i].set_z_index(i)
		queue_redraw()

# Called when the node enters the scene tree for the first time.
func _ready(): # erstellt einen kartenstapel mit den kartenobjekten
	for i in range(4):
		for j in range(13):
			var instance = cardScene.instantiate()
			instance.regionPos = Rect2(40 * j, 60 * i, 40, 60)
			instance.set_position(hide)
			instance.number = j
			match i:
				0: instance.color = "s" # spades
				1: instance.color = "h" # hearts
				2: instance.color = "c" # clubs
				3: instance.color = "d" # diamonds
			stack.append(instance)
			add_child(instance)

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
	
func animPos(pSprite: Object, pPos: Vector2, pDelay):
	var tween = get_tree().create_tween()
	tween.tween_property(pSprite, "position", pPos, 0.25).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT).set_delay(pDelay)
