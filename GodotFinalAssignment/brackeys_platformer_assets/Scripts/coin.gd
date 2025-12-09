extends Area2D
@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(_body: Node2D) -> void:
	var manager : GameManager = game_manager as GameManager
	manager.add_point()
	animation_player.play("Pickup_Animation")
