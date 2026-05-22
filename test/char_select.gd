extends Node2D

@export var Pointer : PackedScene


var Cursors = []



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(len(Globals.PlayerList)):
		var cursor_instance = Pointer.instantiate()
		cursor_instance.set("PlayerNum", i)
		cursor_instance.set("position", Vector2(get_viewport_rect().end.x/2, get_viewport_rect().end.y/2))
		$CanvasLayer.add_child(cursor_instance)

		
		
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
		
	
