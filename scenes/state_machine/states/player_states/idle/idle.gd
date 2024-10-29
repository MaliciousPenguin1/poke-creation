extends PlayerState


func unhandled_input(event: InputEvent) -> void:
	var direction_pressed : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction_pressed != Vector2.ZERO:
		player.facing_direction = Vector2i(direction_pressed.sign())
		state_machine.transition_to("Turn")
