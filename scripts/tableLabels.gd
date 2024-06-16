extends Node2D

# for the values of the player and the pot and game instructions
var infoText = "Its your turn!"
var money: int
var currentBet = 0
var betting = 0
var tablePot = 0
var canRaise = true
var minSlider = 0
var sliderValue = 50

@onready var raiseButton = $"../buttons/raise"
@onready var callButton = $"../buttons/call"
@onready var foldButton = $"../buttons/fold"
@onready var slider = $"../buttons/slider"

@onready var info = $info
@onready var moneten = $moneten
@onready var bet = $bet
@onready var pot = $pot

@onready var sliderLabel = $sliderText

func enableButtons():
	raiseButton.disabled = !canRaise
	callButton.disabled = false
	foldButton.disabled = false
	slider.editable = true

func disableButtons():
	raiseButton.disabled = true
	callButton.disabled = true
	foldButton.disabled = true
	slider.editable = false

func setInfo(pInfo: String):
	info.set_text(pInfo)

func setMoney(pValue: int):
	moneten.set_text("$ " + str(pValue))

func setPlayerBet(pValue: int):

	betting = pValue
	bet.set_text("Current bet: \n$ " + str(currentBet) + "\n" + "Your bet: \n$" + str(pValue))

func setCurrentBet(pValue: int):
	currentBet = pValue
	bet.set_text("Current bet: \n$ " + str(pValue) + "\n" + "Your bet: \n$" + str(betting))
	
func setPot(pValue: int):
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
	setPot(tablePot)

	slider.set_max(money)
	slider.set_min(minSlider)

func _on_slider_value_changed(value: float) -> void:
	sliderValue = value
	sliderLabel.set_text("$ " + str(value))

func _on_slider_changed() -> void:
	sliderValue = minSlider
	slider.value = minSlider
	sliderLabel.set_text("$ " + str(minSlider))
