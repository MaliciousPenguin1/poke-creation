extends Instruction
class_name InstructionWaitForPlayerStep


func consume(_object_to_instruct) -> void:
	await GlobalVar.player.movement_finished
	after_consumed_callback()
