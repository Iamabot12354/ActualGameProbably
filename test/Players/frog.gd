extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

const SPEED = 400.0
const JUMP_VELOCITY = -700.0
const frogJump = -700.0
var jump_num = 0

var max_health = 100
var current_health = 100
var health_regen = 1
var respawn_count = 0
var action = "Idle"
var control


func _physics_process(delta: float) -> void:
	Animate()
	if is_on_floor():
		pass
		# If we are standing still, play idle
		#if velocity.x == 0 and action == "Idle":
			#
			#action = "Idle"
		## If we are moving, play run
		#elif abs(velocity.x) > 0:
			#action = "Hop"
	#
	# --- FLIP SPRITE DIRECTION ---
	# If moving right, face right (flip_h is false)
	if velocity.x > 0:
		anim.flip_h = false
	# If moving left, face left (flip_h is true)
	elif velocity.x < 0:
		anim.flip_h = true
	
	
		
# Add the gravity.
	if not is_on_floor():
		velocity += (get_gravity() * delta) * 2
	else: 
		jump_num = 2
		
		
		

	# Handle jump.
	if Input.is_action_just_pressed("Space") and action != "Attack" and is_on_floor() and control == "Keyboard" or Input.is_action_just_pressed("Controller1Select") and action != "Attack" and is_on_floor() and control == "Controller1" or Input.is_action_just_pressed("Controller2Select") and action != "Attack" and is_on_floor() and control == "Controller2" or Input.is_action_just_pressed("Controller3Select") and action != "Attack" and is_on_floor() and control == "Controller3" or Input.is_action_just_pressed("Controller4Select") and action != "Attack" and is_on_floor() and control == "Controller4":
		
		action = "Hop"
		
		
		$JumpTimer.start()
		
	if Input.is_action_just_released("Space") and control == "Keyboard" or Input.is_action_just_released("Controller1Select") and control == "Controller1" or Input.is_action_just_released("Controller2Select") and control == "Controller2" or Input.is_action_just_released("Controller3Select") and control == "Controller3" or Input.is_action_just_released("Controller4Select") and control == "Controller4":
		
		var time = abs(($JumpTimer.time_left-2))
		
		
		
		if frogJump*time < JUMP_VELOCITY and is_on_floor():
		
			velocity.y += frogJump * time
		
		elif is_on_floor():
			velocity.y += JUMP_VELOCITY
			
		
	
	
	if velocity.y < 0 and action != "Attack":
		action = "Hop"
	elif velocity.y > 0 and action != "Attack":
		action = "Hop"
	
	
	var direction
	if control == "Keyboard":
		direction = Input.get_axis("A", "D")
	elif control == "Controller1":
		direction = Input.get_axis("Controller1Left", "Controller1Right")
	elif control == "Controller2":
		direction = Input.get_axis("Controller2Left", "Controller2Right")
	elif control == "Controller3":
		direction = Input.get_axis("Controller3Left", "Controller3Right")
	elif control == "Controller4":
		direction = Input.get_axis("Controller4Left", "Controller4Right")
	
	
	
	
	if direction:
		velocity.x = direction * SPEED
		if action != "Attack":
			action = "Hop"

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if action != "Attack":
			
			action = "Idle"
		
	if Input.is_action_just_pressed("RMB") and control == "Keyboard" or Input.is_action_just_pressed("Controller1Trigger") and control == "Controller1" or Input.is_action_just_pressed("Controller2Trigger") and control == "Controller2" or Input.is_action_just_pressed("Controller3Trigger") and control == "Controller3" or Input.is_action_just_pressed("Controller4Trigger") and control == "Controller4":
		action = "Attack"
		

		
		
		
		
		

		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	



	move_and_slide()

func take_damage(amount: int):
	current_health -= amount
	
	if current_health < 0:
		current_health = 0
		
	Globals.health_changed.emit(current_health)
	
func Animate():
	if abs(velocity.y) > 0 and action != "Attack":
		action = "Hop"
		
		
	anim.play(action)
	if velocity.y > 0:
		anim.frame = 5
		
	elif velocity.y < 0:
		anim.frame = 3
	
	if action == "Attack" and anim.frame == 5:
		action = "Idle"

		
