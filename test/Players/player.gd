extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

const SPEED = 600.0
const JUMP_VELOCITY = -600.0
var jump_num = 0

var max_health = 100
var current_health = 100
var health_regen = 1
var respawn_count = 0
var anim_over = false

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
	if Input.is_action_just_pressed("Space"):
		
		if is_on_floor() or jump_num < 2:
			velocity.y = JUMP_VELOCITY - 100
			jump_num += 1
		
	if Input.is_action_just_pressed("RMB") and not anim_over:
		anim_over = true
		anim.play("punch")
		
		await anim.animation_finished
		anim_over = false
		
		get_downed_animation()
		
	if current_health == 0:
		
		death_animation()
		
		

		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("A", "D")
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
