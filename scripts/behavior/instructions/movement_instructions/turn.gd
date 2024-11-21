extends Instruction
class_name InstructionTurn

@export var direction : Vector2i
@export var duration : float
@export var random_direction : bool = false


func consume(_object_to_instruct : Entity) -> void:
	if random_direction:
		direction = [Vector2i(0,-1), Vector2i(0,1), Vector2i(-1, 0), Vector2i(1, 0)][randi_range(0, 3)]

	_object_to_instruct.moveable_component.turn(direction)
	_object_to_instruct.state_machine.transition_to("NpcStateIdle", {"duration" : duration, "callback" : after_consumed_callback})
