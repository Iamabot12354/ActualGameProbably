extends Node2D

@onready var sweet = $"Sweet Lava Tropics"
@onready var fruit = $TropicalFruitIsland
@onready var winter = $MythicWinterTundra
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Q") or Input.is_action_just_pressed("ShoulderR"):
		if fruit.visible == true:
			$Hover.play()
			fruit.hide()
			sweet.show()
			winter.hide()
		elif sweet.visible == true:
			$Hover.play()
			fruit.hide()
			sweet.hide()
			winter.show()
		
	if Input.is_action_just_pressed("R") or Input.is_action_just_pressed("ShoulderL"):
		if winter.visible == true:
			$Hover.play()
			fruit.hide()
			sweet.show()
			winter.hide()
		elif sweet.visible == true:
			$Hover.play()
			fruit.show()
			sweet.hide()
			winter.hide()
			
	if Input.is_action_just_pressed("R") or Input.is_action_just_pressed("Controller1Trigger"):
		if winter.visible == true:
			get_tree().change_scene_to_file("res://Icy Tundra/Arena1.tscn")
			$Select.play()
			MusicPlayer.stop()
			MusicPlayer2.stop()

		elif fruit.visible == true:
			get_tree().change_scene_to_file("res://CandyLava/Arena3.tscn")
			$Select.play()
			MusicPlayer.stop()
			MusicPlayer2.stop()

		else:
			get_tree().change_scene_to_file("res://Humid Night/Arena2.tscn")
			$Select.play()
			MusicPlayer.stop()
			MusicPlayer2.stop()
