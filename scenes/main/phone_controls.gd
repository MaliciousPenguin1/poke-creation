extends Control


var phone_os : Array[String] = ["Android", "iOS"]


func _ready() -> void:
	if OS.get_name() not in phone_os:
		queue_free()
	
	show()
