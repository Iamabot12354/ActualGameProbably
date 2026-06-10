extends Node2D

var Colours = [Color(1.0, 0.0, 0.0, 1.0), Color(1.0, 1.0, 0.0, 1.0), Color(0.0, 0.0, 1.0, 1.0), Color(0.0, 1.0, 0.0, 1.0)]

@onready var Points = [$"1st Spawn", $"2nd Spawn", $"3rd Spawn"]

func _ready() -> void:
	

	var podium_count = min(Globals.respawn_list.size(), 3)
		
	var player_scene = preload("res://Players/Player.tscn")

	$Firework1.play("default")
	await get_tree().create_timer(0.2).timeout
	$Firework2.play("default")
	await get_tree().create_timer(0.2).timeout
	$Firework3.play("default")
	await get_tree().create_timer(0.2).timeout
	$Firework4.play("default")
	await get_tree().create_timer(0.2).timeout
	
	MusicPlayer2.play()
	for i in range(podium_count):
		var instance = player_scene.instantiate()

		# PROPERLY read the list backwards
		# The last person added to the list is 1st place, second-to-last is 2nd place, etc.
		var list_index = Globals.respawn_list.size() - 1 - i
		var player_id = Globals.respawn_list[list_index]

		instance.modulate = Colours[player_id]
		instance.position = Points[i].position
		instance.set("anim", "default")
		Globals.respawn_list = []

		add_child(instance)
		

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://ArenaSelect.tscn")
