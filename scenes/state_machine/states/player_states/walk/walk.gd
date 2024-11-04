extends PlayerState

var currentDir : Vector2i
var next_dir : Vector2i

func unhandled_input(event: InputEvent) -> void:
		var direction_pressed : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		next_dir = Vector2i(direction_pressed.sign())


func process(_delta: float) -> void:
	if player.can_move():
		player.move(currentDir)
	
func enter(_message : Dictionary = {}) -> void:
	super()
	currentDir = _message["dir"]
	next_dir = currentDir

func after_walk() -> void:
	if next_dir == Vector2i.ZERO:
		state_machine.transition_to("Idle")
	elif next_dir != currentDir:
		player.facing_direction = next_dir
		state_machine.transition_to("Walk", {"dir" : next_dir})
