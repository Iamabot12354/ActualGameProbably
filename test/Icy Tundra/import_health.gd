extends Node2D

@onready var ui_scene = preload("res://Health Overlay/RainbowCard.tscn")

func _ready() -> void:
	
	show_ui()

func show_ui():
	
	var ui_ins = ui_scene.instantiate()
	
	add_child(ui_ins)
	

	
