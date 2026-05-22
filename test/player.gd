extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -600.0
var jump_num = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else: 
		jump_num = 0

	# Handle jump.
	if Input.is_action_just_pressed("Space"):
		
		if is_on_floor() or jump_num < 2:
			velocity.y = JUMP_VELOCITY
			jump_num += 1
		
	
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("A", "D")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	

	

	move_and_slide()
