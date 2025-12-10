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
		var current_scene_file: = get_tree().current_scene.scene_file_path
		var next_level_number: = current_scene_file.to_int() + 1
		var next_level_path: = "res://Level_" + str(next_level_number) + ".tscn"
		get_tree().change_scene_to_file(next_level_path)
		
		
