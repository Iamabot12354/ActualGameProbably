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
var knock_back
var knock_bonus_x
var knock_bonus_y
var current_knock
var teleLength = 150
var teledir

signal health_changed(current_knock,max_health)






func _physics_process(delta: float) -> void:
	Teleport()
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
		if action != "Attack" and action != "Teleport":
			action = "Hop"

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if action != "Attack" and action != "Teleport":
			
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
	
	if abs(velocity.y) > 0 and action != "Attack" and action != "Teleport":
		action = "Hop"
		
	if action != "Teleport":
		anim.play(action)
	if velocity.y > 0:
		anim.frame = 5
		
	elif velocity.y < 0:
		anim.frame = 3
		
		
	if action == "Teleport":
		
		if anim.animation != "Explosion":
			anim.play("Explosion")
			
		
		if anim.frame == 15 and anim.animation == "Teleport":
			action = "Idle"
		
		
			
	
	
	if action == "Attack" and anim.frame == 5:
		action = "Idle"

		

func knock_mult(amount: int):
	current_knock += amount
	
	if current_knock > 100:
		current_knock = 100
		
	health_changed.emit(current_knock,100)
	
	return (current_knock + amount)


func _on_hurt_box_area_entered(area: Area2D) -> void:
		if area.name == "Hurtbox" and area.owner != self:
		
			if area.owner.has_method("knock_mult"):
				area.owner.knock_mult(10)
				
				
				area.owner.move_over = true
				var knock_direction = sign(area.owner.global_position.x - global_position.x)
				

				if knock_direction == 0: knock_direction = 1 
				
				knock_back = 300 * knock_direction
				knock_bonus_x = 60 * (area.owner.current_knock/10) * knock_direction
				knock_bonus_y = 60 * (area.owner.current_knock/10) 
				
				print(knock_back)
				print(area.owner.current_knock)
				print(knock_bonus_x)
				area.owner.velocity.x = knock_back + knock_bonus_x
				area.owner.velocity.y = -600 * (0.01*knock_bonus_y)
				
				await get_tree().create_timer(0.5).timeout
				if area.owner.is_on_floor():
					area.owner.velocity.x = 0
					area.owner.velocity.y = 0
				await get_tree().create_timer(1).timeout
				area.owner.move_over = false

func Teleport():
	if action == "Teleport":
		if anim.frame == 8:
			$AudioStreamPlayer.play()
			$TeleCooldown.start()
			var leftright
			if control == "Keyboard":
				leftright = Input.get_axis("A", "D")
			elif control == "Controller1":
				leftright = Input.get_axis("Controller1Left", "Controller1Right")
			elif control == "Controller2":
				leftright = Input.get_axis("Controller2Left", "Controller2Right")
			elif control == "Controller3":
				leftright = Input.get_axis("Controller3Left", "Controller3Right")
			elif control == "Controller4":
				leftright = Input.get_axis("Controller4Left", "Controller4Right")
			var updown
			if control == "Keyboard":
				updown = Input.get_axis("W", "S")
			elif control == "Controller1":
				updown = Input.get_axis("Controller1Up", "Controller1Down")
			elif control == "Controller2":
				updown = Input.get_axis("Controller2Up", "Controller2Down")
			elif control == "Controller3":
				updown = Input.get_axis("Controller3Up", "Controller3Down")
			elif control == "Controller4":
				updown = Input.get_axis("Controller4Up", "Controller4Down")
			teledir = Vector2(leftright*teleLength,updown*teleLength)
			
			velocity = Vector2(0, 0)
			
			position += teledir
	
	
	
	if $TeleCooldown.time_left == 0 and control == "Controller1" and Input.is_action_just_released("Square1") or control == "Controller2" and Input.is_action_just_released("Square2") or control == "Controller3" and Input.is_action_just_released("Square3") or control == "Controller4" and Input.is_action_just_released("Square4"):
		action = "Teleport"
		
		
