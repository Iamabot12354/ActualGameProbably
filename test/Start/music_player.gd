extends Node2D

@onready var audio = $AudioStreamPlayer
func stop():
	audio.stop()
func play():
	audio.play()
