extends Instruction
class_name InstructionWalk


@export var direction : Vector2i
@export var random_direction : bool = false
@export var need_to_collide_if_cant_move : bool = true #automatically set to false if random_direction


func consume(_object_to_instruct) -> void:
	var callback_in_case_of_collision = after_consumed_callback
	
	if random_direction:
		need_to_collide_if_cant_move = false
		callback_in_case_of_collision = consume
		direction = [Vector2i(0,-1), Vector2i(0,1), Vector2i(-1, 0), Vector2i(1, 0)][randi_range(0, 3)]

	if _object_to_instruct.facing_direction != direction:
		_object_to_instruct.moveable_component.turn(direction)
	_object_to_instruct.state_machine.transition_to("NpcStateWalk", {"direction" : direction, "callback" : after_consumed_callback, "need_to_collide_if_cant_move" : need_to_collide_if_cant_move, "callback_in_case_of_collision" : callback_in_case_of_collision})
