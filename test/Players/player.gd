extends CharacterBody2D



@onready var anim = $AnimatedSprite2D

const SPEED = 600.0
const JUMP_VELOCITY = -600.0
var jump_num = 0
var control
var max_health = 100
var current_knock = 1
var respawn_count = 0
var anim_over = false
var move_over = false
var knock_bonus_x = 0
var knock_bonus_y = 0
var knock_back = 0

const LASER_BALL_SCENE = preload("res://Ability/Char1/LaserBall/LaserBall.tscn")

signal health_changed(current_knock,max_health)


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
		
	if Input.is_action_just_pressed("LMB") and not anim_over and control == "Keyboard" or Input.is_action_just_pressed("Controller1Trigger") and not anim_over and control == "C1" or Input.is_action_just_pressed("Controller2Trigger") and not anim_over and control == "C2" or Input.is_action_just_pressed("Controller3Trigger") and not anim_over and control == "C3" or Input.is_action_just_pressed("Controller4Trigger") and not anim_over and control == "C4":
		anim_over = true
		anim.play("punch")
		$PunchHit/PunchHit/AnimationPlayer.play("punch_hitbox")
		
		await anim.animation_finished
		anim_over = false
	
	if Input.is_action_just_pressed("E") and not anim_over and control == "Keyboard" or Input.is_action_just_pressed("Square") and not anim_over and control == "Controller":
		shoot_laser()

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
	elif move_over == false:
		velocity.x = move_toward(velocity.x, 0, 100)
	



	move_and_slide()

func knock_mult(amount: int):
	current_knock += amount
	
	if current_knock > 100:
		current_knock = 100
		
	health_changed.emit(current_knock,100)
	
	return (current_knock + amount)
	
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

func _on_punch_hit_area_entered(area: Area2D) -> void:
	
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
			#area.owner.move_over = false
			
func shoot_laser():
	
	var laser = LASER_BALL_SCENE.instantiate()
	
	if anim.flip_h == true:
		laser.direction = -1
		
		
	else:
		laser.direction = 1
		
		
	laser.launcher = self
	
	laser.global_position = global_position
	
	laser.multiplier = current_knock
	
	get_tree().current_scene.add_child(laser)
