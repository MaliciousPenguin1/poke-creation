extends Compass_Instruction
class_name Compass_Instruction_Walk


@export var direction : Vector2i
@export var random_direction : bool


func consume(_object_to_instruct) -> void:
	if random_direction:
		direction = [Vector2i(0,-1), Vector2i(0,1), Vector2i(-1, 0), Vector2i(1, 0)][randi_range(0, 3)]

	if _object_to_instruct.moveable_component.facing_direction != direction:
		_object_to_instruct.moveable_component.turn(direction)
	_object_to_instruct.current_state.state_machine.transition_to("NpcStateWalk", {"direction" : direction, "callback" : after_consumed_callback})
