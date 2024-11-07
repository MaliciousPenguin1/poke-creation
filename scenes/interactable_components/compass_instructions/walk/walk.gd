extends Compass_Instruction


@export var direction : Vector2i


func consume(_object_to_instruct) -> void:
	if _object_to_instruct.moveable_component.facing_direction != direction:
		_object_to_instruct.moveable_component.turn(direction)
	_object_to_instruct.current_state.state_machine.transition_to("Walk", {"direction" : direction, "callback" : after_consumed_callback})
