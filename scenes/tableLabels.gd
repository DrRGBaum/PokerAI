extends Node2D

# for the values of the player and the pot and game instructions
var infoText = "Its your turn!"
var money = 123
var currentBet = 1000
var betting = 2
var tablePot = 900

@onready var info = $info
@onready var moneten = $moneten
@onready var bet = $bet
@onready var pot = $pot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	info.set_text(infoText)
	moneten.set_text("$ " + str(money))
	bet.set_text("Current bet: \n$ " + str(currentBet) + "\n" + "Your bet: \n$" + str(betting))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
