@tool
extends MenuBase


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_cancel"):
		pass
