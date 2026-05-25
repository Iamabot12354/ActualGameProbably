extends Node


@onready var Area = $Area2D
@onready var Collision = $Area2D/CollisionShape2D
@onready var Camera = $Camera2D

#x Scale = 57.6
#y Scale = 32.4

var spawns = [$Player1Spawn, $Player2Spawn, $Player3Spawn, $Player4Spawn]
var scene = preload("res://Player.tscn")
@export var Player : PackedScene = scene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Collision.Scale = Vector2(57.6, 32.4)
	for i in range(len(Globals.PlayerList)):
		var player_Instance = Player.instantiate()
		player_Instance.set("PlayerNum", i)
		player_Instance.set("position", spawns[i].position)
		player_Instance.set("Class", Globals.PlayerChars[i])
		$CanvasLayer.add_child(player_Instance)
		
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
