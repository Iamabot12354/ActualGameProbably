extends Control

@onready var health_bar = $health_bar
@onready var health_bar2 = $health_bar2
@onready var health_bar3 = $health_bar3
@onready var health_bar4 = $health_bar4

func update_health_bar(new_health: int, max_health: int, lives: int):
	health_bar.max_value = max_health
	health_bar.value = new_health
	
	health_bar2.max_value = 1
	health_bar3.max_value = 1
	health_bar4.max_value = 1
	
	if lives == 3:
		health_bar2.value = 1
		health_bar3.value = 1
		health_bar4.value = 1
	elif lives == 2:
		health_bar2.value = 1
		health_bar3.value = 1
		health_bar4.value = 0
	elif lives == 1:
		health_bar2.value = 1
		health_bar3.value = 0
		health_bar4.value = 0
	elif lives <= 0:
		health_bar2.value = 0
		health_bar3.value = 0
		health_bar4.value = 0	
	
