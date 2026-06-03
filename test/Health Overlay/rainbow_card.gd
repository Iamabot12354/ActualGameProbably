extends Control

@onready var health_bar = $health_bar


func update_health_bar(new_health: int, max: int):
	health_bar.max_value = 100
	health_bar.value = new_health
	
	
	
	
