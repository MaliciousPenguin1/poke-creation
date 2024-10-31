extends PlayerState


func unhandled_input(event: InputEvent) -> void:
	var direction_pressed : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction_pressed != Vector2.ZERO:
		var new_dir : Vector2i = Vector2i(direction_pressed.sign())
		player.facing_direction = new_dir
		state_machine.transition_to("Turn", {"counter" : 0, "dir" : new_dir })
