extends Instruction
class_name InstructionWait


@export var duration : float


func consume(_object_to_instruct) -> void:
	await create_tween().tween_interval(duration).finished
	#await get_tree().create_timer(duration, false).timeout
	after_consumed_callback()
