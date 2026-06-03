extends ProgressBar

@onready var health_bar = $health_bar

func update_health_bar(new_health: int):
	health_bar.value = new_health
	
	
func _ready():
	
	health_bar.max_value = 100
	health_bar.value = 100
	
