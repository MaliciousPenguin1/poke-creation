extends Compass_Instruction
class_name Compass_Wait


@export var duration : float


func consume(_object_to_instruct) -> void:
	await get_tree().create_timer(duration, false).timeout
	after_consumed_callback()
