extends PlayerState
class_name PlayerStateWalk

var current_dir : Vector2i
var next_dir : Vector2i

var target_position : Vector2i


func unhandled_input(_event: InputEvent) -> void:
		var direction_pressed : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		next_dir = Vector2i(direction_pressed.sign())


func process(_delta: float) -> void:
	if player.moveable_component.can_move():
		target_position = Vector2i(player.global_position) + current_dir
		if target_position in GlobalVar.reserved_tiles or player.raycast.is_colliding():
			#TODO: play_thud_sound
			state_machine.transition_to("PlayerStateIdle")
		else:
			player.moveable_component.move(current_dir)
			GlobalVar.reserved_tiles.append(target_position)
	
	
func enter(_message : Dictionary = {}) -> void:
	super()
	current_dir = _message["dir"]
	next_dir = current_dir


func after_walk() -> void:
	GlobalVar.reserved_tiles.erase(target_position)
	
	if next_dir == Vector2i.ZERO:
		state_machine.transition_to("PlayerStateIdle")
	elif next_dir != current_dir:
		player.moveable_component.turn(next_dir)
		state_machine.transition_to("PlayerStateWalk", {"dir" : next_dir})
