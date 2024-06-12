extends Node2D

# for the values of the player and the pot and game instructions
var infoText = "Its your turn!"
var money :int
var currentBet = 0
var betting = 0
var tablePot = 0

@onready var info = $info
@onready var moneten = $moneten
@onready var bet = $bet
@onready var pot = $pot

@onready var sliderLabel = $sliderText

func setInfo(pInfo:String):
	info.set_text(pInfo)

func setMoney(pValue:int):
	moneten.set_text("$ " + str(pValue))

func setPlayerBet(pValue:int):
	bet.set_text("Current bet: \n$ " + str(currentBet) + "\n" + "Your bet: \n$" + str(pValue))
	betting = pValue

func setCurrentBet(pValue:int):
	bet.set_text("Current bet: \n$ " + str(pValue) + "\n" + "Your bet: \n$" + str(betting))
	currentBet = pValue

func setPot(pValue:int):
	pot.set_text("$ " + str(pValue))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	info.set_text(infoText)
	moneten.set_text("$ " + str(money))
	bet.set_text("Current bet: \n$ " + str(currentBet) + "\n" + "Your bet: \n$" + str(betting))
	pot.set_text("")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	setInfo(infoText)
	setMoney(money)
	setPlayerBet(betting)
	setCurrentBet(currentBet)
	setPot(tablePot)
	
	await get_tree().create_timer(1).timeout
	pass


func _on_slider_value_changed(value: float) -> void:
	sliderLabel.set_text("$ " + str(value))
	pass # Replace with function body.
