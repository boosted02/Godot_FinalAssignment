extends Node
class_name GameManager
var score: int = 0

@onready var coins: Label = $Collected_Coins
@onready var collected_coins_2: Label = %Collected_Coins2

func add_point() -> void:
	score += 1
	coins.text = "You have collected " + str(score) + " coins."
