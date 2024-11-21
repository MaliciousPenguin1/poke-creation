extends ParallelInstruction
class_name SpotPlayerForBattle


func consume(_object_to_instruct) -> void:
	_object_to_instruct.trainer_raycast.force_raycast_update()
	if _object_to_instruct.trainer_raycast.is_colliding():
		if _object_to_instruct.trainer_raycast.get_collider() is Player:
			var emotion_instruction : Instruction = InstructionPlayEmotion.new()
			emotion_instruction.emotion = InstructionPlayEmotion.EMOTIONS.EXCLAMATION
			var wait_for_player_movement_instruction : Instruction = InstructionWaitForPlayerStep.new()
			var walk_instruction : Instruction = InstructionWalkTowardPlayerOneDirection.new()
			var turn_instruction : Instruction = InstructionTurn.new()
			turn_instruction.direction = Vector2i(-1, 0)
			after_consumed_callback([], [], [emotion_instruction, wait_for_player_movement_instruction, walk_instruction, turn_instruction])
	else:
		after_consumed_callback()
