extends Node2D

var cardScene = preload ("res://scenes/card.tscn")

var color = '' # bsp s für spades
var number: int

# Rect2(40,60,40,60)
var regionPos = Rect2(560, 0, 40, 60)
var cardBack = Rect2(520, 180, 40, 60)
var isVisible: bool = true
var glow: bool = false

#TODO value handler

func visible(pVisible: bool):
	isVisible = pVisible
	if pVisible:
		$PixelPokerTest.region_rect = regionPos
	else:
		$PixelPokerTest.region_rect = cardBack
	pass

func setGlow(pGlow: bool):
	glow = pGlow
	$glow.visible = pGlow
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	$PixelPokerTest.region_rect = regionPos
	
	queue_redraw()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
