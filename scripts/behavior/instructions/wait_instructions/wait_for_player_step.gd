extends Instruction
class_name InstructionWaitForPlayerStep


func consume(_object_to_instruct) -> void:
	if GlobalVar.player.moveable_component.is_moving:
		await GlobalVar.player.movement_finished
	after_consumed_callback()
