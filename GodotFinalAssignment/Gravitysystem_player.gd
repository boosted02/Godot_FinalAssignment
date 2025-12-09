extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -250.0
const DASH_VELOCITY = 400

# Added types to prevent errors
var dashing: bool = false
var can_dash: bool = true

# 1 = Normal (Down), -1 = Reverse (Up)
var gravity_direction: int = 1 

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite: = $AnimatedSprite2D 
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("GravityShift"):
		shift_gravity()

	# --- MODIFIED: Gravity Application ---
	if not is_on_floor():
		velocity.y += gravity * gravity_direction * delta

	# --- MODIFIED: Handle jump ---
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY * gravity_direction
	
	# --- EXISTING DASH LOGIC (Unchanged) ---
	if Input.is_action_just_pressed("Dash") and can_dash:
		dashing = true
		can_dash = false
		($Dash_Timer as Timer).start()
		($dash_again_Timer as Timer).start()

	# Gets movement direction
	var direction := Input.get_axis("Move_Left", "Move_Right")
	
	# Flips the sprite horizontally (Left/Right)
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Playing Animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")

	# Applies the direction
	if direction:
		if dashing:
			velocity.x = direction * DASH_VELOCITY
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# --- NEW: Custom Function to handle the flip ---
func shift_gravity() -> void:
	gravity_direction *= -1 # Flips between 1 and -1
	
	if gravity_direction == 1:
		up_direction = Vector2.UP # Floor is below
		#animated_sprite.flip_v = false # Character stands upright
		rotation_degrees = 0
	else:
		up_direction = Vector2.DOWN # Floor is above (Ceiling)
		#animated_sprite.flip_v = true # Character stands upside down
		rotation_degrees = 180

# Dashing Timer so we don't stay in dash state.
func _on_dash_timer_timeout() -> void:
	dashing = false

# Prevent Dashing again and again.
func _on_dash_again_timer_timeout() -> void:
	can_dash = true
