extends Area2D

var can_tp: = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player": # Good practice: Make sure it's actually the player
		print("Press F to interact")
		can_tp = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		print("Left interaction zone")
		can_tp = false

func _process(delta: float) -> void:
	if can_tp and Input.is_action_just_pressed("Interact"):
		print("You interacted!")
		
