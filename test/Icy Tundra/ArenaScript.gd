extends Node2D


@onready var Area = $Area2D
@onready var Collision = $Area2D/CollisionShape2D
@onready var Camera = $Camera2D

var colour

var max_zoom = 0.62

#x Scale = 57.6
#y Scale = 32.4

@onready var spawns = [$Player1Spawn, $Player2Spawn, $Player3Spawn, $Player4Spawn]
var scene = preload("res://Players//Player.tscn")
var frog = preload("res://Players/Frog.tscn")
@export var Player : PackedScene = scene

@onready var ui_scene = preload("res://Health Overlay/RainbowCard.tscn")
const Laser_ball = preload("res://Ability/Char1/LaserBall/LaserBall.tscn")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	


	
	for i in range(len(Globals.PlayerList)):
		var player_Instance
		if Globals.PlayerChars[i] == 0:
			player_Instance = Player.instantiate()
		elif Globals.PlayerChars[i] == 1:
			player_Instance = frog.instantiate()
		
		player_Instance.set("PlayerNum", i)
		player_Instance.set("control", Globals.PlayerList[i])
		player_Instance.set("position", spawns[i].position)
		player_Instance.set("Class", Globals.PlayerChars[i])
		
		if i == 0:
			colour = Color(1.0, 0.0, 0.0, 1.0)
		elif i == 1:
			colour = Color(1.0, 1.0, 0.0, 1.0)
		elif i == 2:
			colour = Color(0.0, 0.0, 1.0, 1.0)
		elif i == 3:
			colour = Color(0.0, 1.0, 0.0, 1.0)
		
		player_Instance.set("modulate",colour) 
		#control = Globals.PlayerList[PlayerNum]   
		var ui_ins = ui_scene.instantiate()
		
		player_Instance.health_changed.connect(ui_ins.update_health_bar)
		add_child(player_Instance)
		$CanvasLayer/HBoxContainer.add_child(ui_ins)
		player_Instance.health_changed.emit(player_Instance.current_knock, player_Instance.max_health, player_Instance.respawns)
	



	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if len(Globals.respawn_list) == len(Globals.PlayerList):
		get_tree().change_scene_to_file("res://ScoreScreen.tscn")


func _on_area_2d_body_exited(body: Node2D) -> void:
	
	
	if body.is_in_group("Player") and Camera.zoom >= Vector2(0.8,0.8):
		Camera.zoom -= Vector2(0.2 ,0.2)
		print("zoom1 out")

func _on_death_floor_body_entered(body: Node2D) -> void:
	$DeathSound.play()
	body.respawn()
	
	var total_players_in_match = len(Globals.PlayerList)

	if Globals.respawn_list.size() == total_players_in_match - 1:

		var all_possible_ids = [0, 1, 2, 3]
		for id in all_possible_ids:
			if not Globals.respawn_list.has(id):
				Globals.respawn_list.append(id)
				break

		get_tree().change_scene_to_file("res://ScoreScreen.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("Player") and Camera.zoom < Vector2(1,1):
		Camera.zoom += Vector2(0.2,0.2)
		print("zoom1 in")

func _on_second_s_tage_body_exited(body: Node2D) -> void:
	
	
	if body.is_in_group("Player") and Camera.zoom >= Vector2(0.6,0.6):
		Camera.zoom -= Vector2(0.2 ,0.2)
		print("zoom2 out")
		

func _on_second_s_tage_body_entered(body: Node2D) -> void:
		
	if body.is_in_group("Player") and Camera.zoom < Vector2(0.8,0.8):
		Camera.zoom += Vector2(0.2 ,0.2)
		print("zoom2 in")

func _on_third_stage_body_exited(body: Node2D) -> void:
	
	
	if body.is_in_group("Player") and Camera.zoom < Vector2(1,1):
		Camera.zoom += Vector2(0.2,0.2)
		print("zoom3 in")

func _on_fourth_stage_body_exited(body: Node2D) -> void:
	
	
	if body.is_in_group("Player") and Camera.zoom < Vector2(1,1):
		Camera.zoom += Vector2(0.2,0.2)
		print("zoom4 in")
