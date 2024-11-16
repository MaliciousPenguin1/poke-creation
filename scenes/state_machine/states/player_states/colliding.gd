extends PlayerState
class_name PlayerStateColliding


var current_dir : Vector2i
var next_dir : Vector2i



func _ready() -> void:
	await super()
	player.finished_bumping.connect(_on_finished_bumping)
	

func enter(_message : Dictionary = {}) -> void:
	super()
	current_dir = _message["dir"]
	next_dir = current_dir
	player.moveable_component.initiate_collision()


func unhandled_input(_event: InputEvent) -> void:
	var direction_pressed : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	next_dir = Vector2i(direction_pressed.sign())


func _on_finished_bumping() -> void:
	if next_dir == Vector2i(0, 0):
		state_machine.transition_to("PlayerStateIdle")
	elif next_dir != current_dir:
		player.moveable_component.turn(next_dir)
		state_machine.transition_to("PlayerStateWalk", {"dir" : next_dir})
	else:
		state_machine.transition_to("PlayerStateWalk", {"dir" : current_dir})
