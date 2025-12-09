extends Node
class_name GameManager
var score: int = 0

@onready var coins: Label = $Collected_Coins

func add_point() -> void:
	score += 1
	coins.text = "You have collected " + str(score) + " coins."
