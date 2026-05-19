extends Node2D







# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.Player4 == null:
		if Globals.Player2 == null:
			if "Keyboard" not in Globals.PlayerList:
				if Input.is_action_just_released("MouseDown"):
					Globals.Players+= 1
					Globals.Player2 = "Keyboard"
					Globals.PlayerList.append("Keyboard")
			if "Controller1" not in Globals.PlayerList:
				if Input.is_action_just_released("Controller1Select"):
					Globals.Players+= 1
					Globals.Player2 = "Controller1"
					Globals.PlayerList.append("Controller1")
			if "Controller2" not in Globals.PlayerList:
				if Input.is_action_just_released("Controller2Select"):
					Globals.Players+= 1
					Globals.Player2 = "Controller2"
					Globals.PlayerList.append("Controller2")
			if "Controller3" not in Globals.PlayerList:
				if Input.is_action_just_released("Controller3Select"):
					Globals.Players+= 1
					Globals.Player2 = "Controller3"
					Globals.PlayerList.append("Controller3")
			if "Controller4" not in Globals.PlayerList:
				if Input.is_action_just_released("Controller4Select"):
					Globals.Players+= 1
					Globals.Player2 = "Controller4"
					Globals.PlayerList.append("Controller4")
		if Globals.Player3 == null:
			if "Keyboard" not in Globals.PlayerList:
				if Input.is_action_just_released("MouseDown"):
					Globals.Players+= 1
					Globals.Player3 = "Keyboard"
					Globals.PlayerList.append("Keyboard")
			if "Controller1" not in Globals.PlayerList:
				if Input.is_action_just_released("Controller1Select"):
					Globals.Players+= 1
					Globals.Player3 = "Controller1"
					Globals.PlayerList.append("Controller1")
			if "Controller2" not in Globals.PlayerList:
				if Input.is_action_just_released("Controller2Select"):
					Globals.Players+= 1
					Globals.Player3 = "Controller2"
					Globals.PlayerList.append("Controller2")
			if "Controller3" not in Globals.PlayerList:
				if Input.is_action_just_released("Controller3Select"):
					Globals.Players+= 1
					Globals.Player3 = "Controller3"
					Globals.PlayerList.append("Controller3")
			if "Controller4" not in Globals.PlayerList:
				if Input.is_action_just_released("Controller4Select"):
					Globals.Players+= 1
					Globals.Player3 = "Controller4"
					Globals.PlayerList.append("Controller4")
		if Globals.Player4 == null:
			if "Keyboard" not in Globals.PlayerList:
				if Input.is_action_just_released("MouseDown"):
					Globals.Players+= 1
					Globals.Player4 = "Keyboard"
					Globals.PlayerList.append("Keyboard")
			if "Controller1" not in Globals.PlayerList:
				if Input.is_action_just_released("Controller1Select"):
					Globals.Players+= 1
					Globals.Player4 = "Controller1"
					Globals.PlayerList.append("Controller1")
			if "Controller2" not in Globals.PlayerList:
				if Input.is_action_just_released("Controller2Select"):
					Globals.Players+= 1
					Globals.Player4 = "Controller2"
					Globals.PlayerList.append("Controller2")
			if "Controller3" not in Globals.PlayerList:
				if Input.is_action_just_released("Controller3Select"):
					Globals.Players+= 1
					Globals.Player4 = "Controller3"
					Globals.PlayerList.append("Controller3")
			if "Controller4" not in Globals.PlayerList:
				if Input.is_action_just_released("Controller4Select"):
					Globals.Players+= 1
					Globals.Player4 = "Controller4"
					Globals.PlayerList.append("Controller4")
	
	
	
	
