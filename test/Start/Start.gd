extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if Input.is_action_just_released("MouseDown"):
		Globals.Players+= 1
		Globals.Player1 = "Keyboard"
		Globals.PlayerList.append("Keyboard")
	elif Input.is_action_just_released("Controller1Select"):
		Globals.Players+= 1
		Globals.Player1 = "Controller1"
		Globals.PlayerList.append("Controller1")
	elif Input.is_action_just_released("Controller2Select"):
		Globals.Players+= 1
		Globals.Player1 = "Controller2"
		Globals.PlayerList.append("Controller2")
	elif Input.is_action_just_released("Controller3Select"):
		Globals.Players+= 1
		Globals.Player1 = "Controller3"
		Globals.PlayerList.append("Controller3")
	elif Input.is_action_just_released("Controller4Select"):
		Globals.Players+= 1
		Globals.Player1 = "Controller4"
		Globals.PlayerList.append("Controller4")
	
	print(Globals.Player1)
	
		
	
	
	get_tree().change_scene_to_file("res://CharSelect.tscn")
