extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -250.0
const DASH_VELOCITY = 400
var dashing: = false
var can_dash: = true
var gravity_direction: = 1

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite: = $AnimatedSprite2D
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")




func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("Dash") and can_dash:
		dashing = true
		can_dash = false
		($Dash_Timer as Timer).start()
		($dash_again_Timer as Timer).start()
#Gets movement directio, Can either be -1, 0, 1
	var direction := Input.get_axis("Move_Left", "Move_Right")
	
	#Flips the sprite.
	if direction >0:
		animated_sprite.flip_h= false
	elif direction <0:
		animated_sprite.flip_h= true
	
	#playing Animation.
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")
	#This applies the direction.
	if direction:
		if dashing:
			velocity.x = direction * DASH_VELOCITY
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Dashing Timer so we don't stay in dash state.
func _on_dash_timer_timeout() -> void:
	dashing = false

# Prevent Dashing again and again.
func _on_dash_again_timer_timeout() -> void:
	can_dash = true
