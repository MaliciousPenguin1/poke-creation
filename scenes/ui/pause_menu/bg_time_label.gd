extends Label


func _ready() -> void:
	text = GameTime.get_formatted_current_time()
