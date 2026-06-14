extends Node2D

@export var Pointer : PackedScene


var Cursors = []



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(len(Globals.PlayerList)):
		var cursor_instance = Pointer.instantiate()
		cursor_instance.set("PlayerNum", i)
		cursor_instance.set("position", Vector2(0, 0))
		$CanvasLayer.add_child(cursor_instance)
	if Input.is_action_just_pressed("R") or Input.is_action_just_pressed("Controller1Trigger"):
		get_tree().change_scene_to_file("res://ArenaSelect.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.PlayerChars.count(null) == 4-len(Globals.PlayerList):
		$Button.grab_focus()
	else:
		$Button.release_focus()
		
	

func _on_button_pressed() -> void:
	
	get_tree().change_scene_to_file("res://ArenaSelect.tscn")
