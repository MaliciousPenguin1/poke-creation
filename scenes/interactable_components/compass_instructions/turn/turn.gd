extends Compass_Instruction


@export var direction : Vector2i
@export var duration : float


func consume(_object_to_instruct) -> void:
	_object_to_instruct.moveable_component.turn(direction)
	_object_to_instruct.current_state.state_machine.transition_to("Idle", {"duration" : duration, "callback" : after_consumed_callback})
