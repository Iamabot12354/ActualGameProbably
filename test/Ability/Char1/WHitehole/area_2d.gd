extends Area2D



const PUSH_SPEED = 300.0 

func _ready() -> void:
	
	$"../AnimationPlayer".play("GROWTH")
	$"../AddWhiteHole".play()
	await get_tree().create_timer(2.2).timeout
	$"../AnimationPlayer".play("pulse")
	$"../WhiteHoleIdle".play()
	await get_tree().create_timer(15).timeout
	$"../AnimationPlayer".play_backwards("GROWTH")
	$"../WhiteHoleIdle".stop()
	$"../AddWhiteHole".play()
	await get_tree().create_timer(2).timeout
	queue_free()
	
func _physics_process(delta: float) -> void:

	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body is CharacterBody2D:

			var direction = global_position.direction_to(body.global_position)

			body.move_and_collide(direction * PUSH_SPEED * delta)
			
	
