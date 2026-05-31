extends Node2D

@export var UserIMG : Texture
@export var Text : String
@export var FOCUS : bool
@export var Path : String



@onready var IMG = $Button
@onready var Name = $Label



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if FOCUS:
		IMG.grab_focus()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	IMG.icon = UserIMG
	Name.text = Text
	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(Path)
