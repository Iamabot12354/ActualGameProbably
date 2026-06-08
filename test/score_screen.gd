extends Node2D

var Colours = [Color(1.0, 0.0, 0.0, 1.0),Color(1.0, 1.0, 0.0, 1.0),Color(0.0, 0.0, 1.0, 1.0),Color(0.0, 1.0, 0.0, 1.0)]
var Points = [$"1st Spawn", $"2nd Spawn", $"3rd Spawn"]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#if len(Globals.respawns) < 3:
		#for i in range(len(Globals.respawns)):
			#var scene = preload("res://Players//Player.tscn")
			#scene.set("modulate", Colours[i])
			#scene.set("position", Points[i].position)
			#scene.set("anim", "defult")
	#else:
		#for i in range(3):
			#var scene = preload("res://Players//Player.tscn")
			#scene.set("modulate", Colours[i])
			#scene.set("position", Points[i].position)
			#scene.set("anim", "defult")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().quit()


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://ArenaSelect.tscn")
