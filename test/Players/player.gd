extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

const SPEED = 600.0
const JUMP_VELOCITY = -600.0
var jump_num = 0
var control
var max_health = 100
var current_health = 100
var health_regen = 1
var respawn_count = 0
var anim_over = false


func _ready() -> void:
	if control == "Controller1":
		control = "C1"
	elif control == "Controller2":
		control = "C2"
	elif control == "Controller3":
		control = "C3"
	elif control == "Controller4":
		control = "C4"


func _physics_process(delta: float) -> void:
	
	if not anim_over:
		if is_on_floor():
			# If we are standing still, play idle
			if velocity.x == 0:
				anim.play("default")
			# If we are moving, play run
			else:
				anim.play("run")
		
		# --- FLIP SPRITE DIRECTION ---
		# If moving right, face right (flip_h is false)
		if velocity.x > 0:
			anim.flip_h = false
		# If moving left, face left (flip_h is true)
		elif velocity.x < 0:
			anim.flip_h = true
		
		if velocity.y < 0:
			anim.play("jump")
			
	# Add the gravity.
	if not is_on_floor():
		velocity += (get_gravity() * delta) * 2
	else: 
		jump_num = 0

	# Handle jump.
	if Input.is_action_just_pressed("Space") and control == "Keyboard" or Input.is_action_just_pressed("Controller1Select") and control == "C1" or Input.is_action_just_pressed("Controller2Select") and control == "C2" or Input.is_action_just_pressed("Controller3Select") and control == "C3" or Input.is_action_just_pressed("Controller4Select") and control == "C4":
		
		if is_on_floor() or jump_num < 2:
			velocity.y = JUMP_VELOCITY - 100
			jump_num += 1
		
	if Input.is_action_just_pressed("RMB") and not anim_over and control == "Keyboard" or Input.is_action_just_pressed("Controller1Trigger") and not anim_over and control == "C1" or Input.is_action_just_pressed("Controller2Trigger") and not anim_over and control == "C2" or Input.is_action_just_pressed("Controller3Trigger") and not anim_over and control == "C3" or Input.is_action_just_pressed("Controller4Trigger") and not anim_over and control == "C4":
		anim_over = true
		anim.play("punch")
		
		await anim.animation_finished
		anim_over = false
		
		get_downed_animation()
		
	if current_health == 0:
		
		death_animation()
		
		

		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction
	if control == "Keyboard":
		direction = Input.get_axis("A", "D")
	elif control == "C1":
		direction = Input.get_axis("Controller1Left", "Controller1Right")
	elif control == "C2":
		direction = Input.get_axis("Controller2Left", "Controller2Right")
	elif control == "C3":
		direction = Input.get_axis("Controller3Left", "Controller3Right")
	elif control == "C4":
		direction = Input.get_axis("Controller4Left", "Controller4Right")
	if direction and not anim_over:
		velocity.x = direction * SPEED

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	



	move_and_slide()

func take_damage(amount: int):
	current_health -= amount
	
	if current_health < 0:
		current_health = 0
		
	Globals.health_changed.emit(current_health)
	
func get_downed_animation():
	
	anim_over = true
	anim.play("knockback")
	
	await anim.animation_finished
	anim_over = false

func death_animation():
	
	anim_over = true
	anim.play("knockback")
	
	await anim.animation_finished
	anim_over = false

#func 
