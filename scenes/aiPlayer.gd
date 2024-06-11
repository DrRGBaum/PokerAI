extends Node2D

var aiMoney = [420,69,42,187]
var aiBettings = [0,1,2,3]

@onready var aiMoneten = [$aiMoneten0,$aiMoneten1,$aiMoneten2,$aiMoneten3]
@onready var aiBet = [$bet0,$bet1,$bet2,$bet3]

func _ready() -> void: # sets the variables when node is created
	for i in range(4):
		aiMoneten[i].set_text("$ " + str(aiMoney[i]))
		if aiBettings[i] != null and aiBettings[i] != 0:
			aiBet[i].set_text("$ " + str(aiBettings[i]))
		else:
			aiBet[i].set_text("")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
