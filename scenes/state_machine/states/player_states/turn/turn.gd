extends PlayerState

var pressed_since : float
var current_dir : Vector2i


func unhandled_input(_event: InputEvent) -> void:
	var direction_pressed : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var new_dir : Vector2i = Vector2i(direction_pressed.sign())
	if new_dir != current_dir:
		if (new_dir.x == current_dir.x and current_dir.x != 0) or (new_dir.y == current_dir.y and current_dir.y != 0):
			player.facing_direction = new_dir
			state_machine.transition_to("Turn", {"counter" : pressed_since, "dir" : new_dir })
		else:
			state_machine.transition_to("Idle")


func process(_delta: float) -> void:
	pressed_since += _delta
	if pressed_since > GlobalConstants.DELAY_BEFORE_WALKING:
		state_machine.transition_to("Walk", {"dir" : current_dir})


func enter(_message : Dictionary = {}) -> void:
	super()
	pressed_since = _message["counter"]
	current_dir = _message["dir"]
	
