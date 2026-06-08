extends Node2D

const SPEED = 800
var direction = 1
var launcher = null
var multiplier = 1

func _physics_process(delta: float) -> void:
	position.x += direction * SPEED * delta
	
	if direction < 0:
		$Area2D/Sprite2D.flip_h = false
	elif direction > 0:
		$Area2D/Sprite2D.flip_h = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("knock_mult") and body != launcher:
		body.knock_mult(20)
		
		if "move_over" in body:
			body.move_over = true
			body.velocity.x = direction * 1000 * (multiplier/100)
			body.velocity.y = -400
			await get_tree().create_timer(0.5).timeout
			body.move_over = false
			
	
	#queue_free()
