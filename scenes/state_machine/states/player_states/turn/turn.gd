extends PlayerState

var pressedSince : float
var currentDir : Vector2i

func unhandled_input(event: InputEvent) -> void:
	var direction_pressed : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var new_dir : Vector2i = Vector2i(direction_pressed.sign())
	if new_dir != currentDir:
		if (new_dir.x == currentDir.x and currentDir.x != 0) or (new_dir.y == currentDir.y and currentDir.y != 0):
			player.facing_direction = new_dir
			state_machine.transition_to("Turn", {"counter" : pressedSince, "dir" : new_dir })
		else:
			state_machine.transition_to("Idle")

func process(_delta: float) -> void:
	pressedSince += _delta
	if pressedSince > GlobalConstants.DELAY_BEFORE_WALKING:
		state_machine.transition_to("Walk", {"dir" : currentDir})

func enter(_message : Dictionary = {}) -> void:
	super()
	pressedSince = _message["counter"]
	currentDir = _message["dir"]
	
