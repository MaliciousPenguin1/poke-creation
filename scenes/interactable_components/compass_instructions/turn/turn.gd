extends Compass_Instruction


@export var direction : Vector2i
@export var duration : float


func consume(object_to_instruct) -> void:
	object_to_instruct.moveable_component.turn(direction)
	object_to_instruct.current_state.transition_to("Idle", {"duration" : duration, "callback" : after_consumed_callback})
