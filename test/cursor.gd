extends CharacterBody2D

var PlayerNum = null
var control
@export var Sense : int
var colour = Color(1.0, 0.0, 0.0, 1.0)
var Selected = false
var char = null
var InArea = false
var newArea : Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	if PlayerNum == 0:
		colour = Color(1.0, 0.0, 0.0, 1.0)
	elif PlayerNum == 1:
		colour = Color(1.0, 1.0, 0.0, 1.0)
	elif PlayerNum == 2:
		colour = Color(0.0, 0.0, 1.0, 1.0)
	elif PlayerNum == 3:
		colour = Color(0.0, 1.0, 0.0, 1.0)
	
	$Sprite2D.self_modulate = colour
	control = Globals.PlayerList[PlayerNum]   

func Move(delta) -> void:
	if Selected == false:
		if control == "Keyboard":
			position = get_global_mouse_position()
			#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
			
			
		elif control == "Controller1":
			if Input.is_action_pressed("Controller1Up"):
				position.y = position.y - Sense*delta
			if Input.is_action_pressed("Controller1Down"):
				position.y = position.y + Sense*delta
			if Input.is_action_pressed("Controller1Left"):
				position.x = position.x-	Sense*delta
			if Input.is_action_pressed("Controller1Right"):
				position.x = position.x +Sense*delta
		elif control == "Controller2":
			if Input.is_action_pressed("Controller2Up"):
				position.y = position.y - Sense*delta
			if Input.is_action_pressed("Controller2Down"):
				position.y = position.y + Sense*delta
			if Input.is_action_pressed("Controller2Left"):
				position.x = position.x - Sense*delta
			if Input.is_action_pressed("Controller2Right"):
				position.x = position.x+	Sense*delta
		elif control == "Controller3":
			if Input.is_action_pressed("Controller3Up"):
				position.y = position.y - Sense*delta
			if Input.is_action_pressed("Controller3Down"):
				position.y = position.y + Sense*delta
			if Input.is_action_pressed("Controller3Left"):
				position.x = position.x - Sense*delta
			if Input.is_action_pressed("Controller3Right"):
				position.x = position.x + Sense*delta
		elif control == "Controller4":
			if Input.is_action_pressed("Controller4Up"):
				position.y = position.y - Sense*delta
			if Input.is_action_pressed("Controller4Down"):
				position.y = position.y + Sense*delta
			if Input.is_action_pressed("Controller4Left"):
				position.x = position.x - Sense*delta
			if Input.is_action_pressed("Controller4Right"):
				position.x = position.x + Sense*delta
		
		move_and_slide()

func Select_deselect(Area : Area2D) -> void:

	if Input.is_action_just_released("Controller1Select") and control == "Controller1" or Input.is_action_just_released("Controller2Select") and control == "Controller2" or Input.is_action_just_released("Controller3Select") and control == "Controller3" or Input.is_action_just_released("Controller4Select") and control == "Controller4" or Input.is_action_just_released("MouseDown") and control == "Keyboard":
		if Selected == false:
			Selected = true
			Globals.Ready += 1
			
			Globals.PlayerChars[PlayerNum] = 0
			
			
			
		else:
			Selected = false
			Globals.Ready -= 1
			Globals.PlayerChars[PlayerNum] = null
		
		

func _process(delta: float) -> void:
	if InArea:
		
		Select_deselect(newArea)
		
	Move(delta)
	
	
	



func _on_area_2d_area_entered(area: Area2D) -> void:
	InArea = true
	newArea = area


func _on_area_2d_area_exited(area: Area2D) -> void:
	InArea = false
