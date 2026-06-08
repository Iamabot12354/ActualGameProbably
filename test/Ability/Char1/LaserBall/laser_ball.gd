extends Node2D

const SPEED = 800
var direction = 1
var launcher = null
var multiplier = 1

func _ready() -> void:
	

	$AddWhiteHole.play()
	$AddWhiteHole2.play()
	

	
func _physics_process(delta: float) -> void:
	position.x += direction * SPEED * delta
	
	if direction < 0:
		$Area2D/Sprite2D.flip_h = false
	elif direction > 0:
		$Area2D/Sprite2D.flip_h = true

func _on_area_2d_body_entered(area: Node2D) -> void:
	if area.has_method("knock_mult") and area != launcher and not area.blocking:
		area.knock_mult(1)
		
		
		area.move_over = true
		var knock_direction = sign(area.global_position.x - global_position.x)
		

		if knock_direction == 0: knock_direction = 1 
		
		var knock_back = 300 * knock_direction
		var knock_bonus_x = 60 * (area.current_knock/10) * knock_direction
		var knock_bonus_y = 60 * (area.current_knock/10) 

		
		print(knock_back)
		print(area.current_knock)
		print(knock_bonus_x)
		area.velocity.x = knock_back + knock_bonus_x
		area.velocity.y = -600 * (0.01*knock_bonus_y)
		
		await get_tree().create_timer(0.5).timeout
		if area.is_on_floor():
			area.velocity.x = 0
			area.velocity.y = 0
		await get_tree().create_timer(1).timeout
		area.move_over = false
			
	
