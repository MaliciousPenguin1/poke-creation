extends Label


func _ready() -> void:
	var time : Dictionary = Time.get_time_dict_from_system()
	text = str(time["hour"]) + ":" + str(time["minute"])
	text = "19:17"
