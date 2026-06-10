extends Control

@onready var Img1 = $HBoxContainer/Sprite2D
@onready var Img2 = $HBoxContainer/Sprite2D2
@onready var Img3 = $HBoxContainer/Sprite2D3
@onready var Img4 = $HBoxContainer/Sprite2D4

var Imgs = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Imgs = [Img1, Img2, Img3, Img4]

	MusicPlayer2.stop()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	for i in range(len(Globals.PlayerList)):
		Imgs[i].show()
	
	for i in range(len(Globals.PlayerList), 4):
		Imgs[i].hide()
