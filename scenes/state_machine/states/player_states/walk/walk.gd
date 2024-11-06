extends PlayerState

var current_dir : Vector2i
var next_dir : Vector2i

func unhandled_input(_event: InputEvent) -> void:
		var direction_pressed : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		next_dir = Vector2i(direction_pressed.sign())


func process(_delta: float) -> void:
	if player.moveable_component.can_move():
		player.moveable_component.move(current_dir)
	
	
func enter(_message : Dictionary = {}) -> void:
	super()
	current_dir = _message["dir"]
	next_dir = current_dir


func after_walk() -> void:
	if next_dir == Vector2i.ZERO:
		state_machine.transition_to("Idle")
	elif next_dir != current_dir:
		player.facing_direction = next_dir
		state_machine.transition_to("Walk", {"dir" : next_dir})
