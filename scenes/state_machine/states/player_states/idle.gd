extends PlayerState
class_name PlayerStateIdle


func unhandled_input(_event: InputEvent) -> void:
	var direction_pressed : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction_pressed != Vector2.ZERO:
		var new_dir : Vector2i = Vector2i(direction_pressed.sign())
		player.moveable_component.turn(new_dir)
		state_machine.transition_to("PlayerStateTurn", {"counter" : 0, "dir" : new_dir })
	elif Input.is_action_just_pressed("pause"):
		ScenesManager.show_pause_menu()
