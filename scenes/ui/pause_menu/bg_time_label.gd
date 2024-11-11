extends Label


func _ready() -> void:
	var time : Dictionary = Time.get_time_dict_from_system()
	text = GameTime.get_formatted_current_time()
