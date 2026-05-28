extends Node

#
#@onready var Area = $Area2D
#@onready var Collision = $Area2D/CollisionShape2D
#@onready var Camera = $Camera2D

#x Scale = 57.6
#y Scale = 32.4






# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spawns = [$Player1Spawn, $Player2Spawn, $Player3Spawn, $Player4Spawn]
	#Collision.scale = Vector2(57.6, 32.4)
	for i in range(len(Globals.PlayerList)):
		var scene = preload("res://Players/Player.tscn")
		if Globals.PlayerChars[i] == 0:
			scene = preload("res://Players/Player.tscn")
		elif Globals.PlayerChars[i] == 1:
			scene = preload("res://Players/Frog.tscn")
		var player_Instance = scene.instantiate()
		player_Instance.set("PlayerNum", i)
		player_Instance.set("position", spawns[i].position)
		player_Instance.set("control", Globals.PlayerList[i])
		
		$CanvasLayer.add_child(player_Instance)
		
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
