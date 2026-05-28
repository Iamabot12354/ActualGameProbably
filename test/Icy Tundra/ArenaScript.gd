extends Node2D


@onready var Area = $Area2D
@onready var Collision = $Area2D/CollisionShape2D
@onready var Camera = $Camera2D

var max_zoom = 0.62

#x Scale = 57.6
#y Scale = 32.4

var spawns = [$Player1Spawn, $Player2Spawn, $Player3Spawn, $Player4Spawn]
var scene = preload("res://Players//Player.tscn")
@export var Player : PackedScene = scene

@onready var ui_scene = preload("res://Health Overlay/RainbowCard.tscn")

func show_ui():
	
	var ui_ins = ui_scene.instantiate()
	
	$CanvasLayer.add_child(ui_ins)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	show_ui()
	
	#Collision.scale.x = 57.6
	#Collision.scale.y = 32.4
	
	for i in range(len(Globals.PlayerList)):
		var player_Instance = Player.instantiate()
		player_Instance.set("PlayerNum", i)
		player_Instance.set("position", spawns[i].position)
		player_Instance.set("Class", Globals.PlayerChars[i])
		$CanvasLayer.add_child(player_Instance)

	



	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	
	print("zoom")
	if $CharacterBody2D.is_in_group("Player") and Camera.zoom >= Vector2(0.6,0.6):
		Camera.zoom -= Vector2(0.2 ,0.2)

func _on_death_floor_body_entered(body: Node2D) -> void:
	
	if $CharacterBody2D.is_in_group("Player") and Camera.zoom < Vector2(1,1):
		Camera.zoom += Vector2(0.2,0.2)
		
	#if $CharacterBody2D.is_in_group("Player"):
		#$CharacterBody2D.queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	
		if $CharacterBody2D.is_in_group("Player") and Camera.zoom < Vector2(1,1):
			Camera.zoom += Vector2(0.2,0.2)
