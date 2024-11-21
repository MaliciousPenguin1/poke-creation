extends Instruction
class_name InstructionWalkTowardPlayerOneDirection


func consume(_object_to_instruct) -> void:
	var pos_difference : Vector2i = GlobalVar.player.global_position - _object_to_instruct.global_position
	assert(pos_difference.x*pos_difference.y == 0, "The Entity need to face the Player before executing InstructionWalkTowardPlayerOneDirection")
	
	var nb_steps_to_do : int = (abs(pos_difference.x + pos_difference.y) - 1)/GlobalConstants.TILES_SIZE
	var walk_instructions : Array[Instruction] = []
	var current_walk_instruction : InstructionWalk
	for i in range(nb_steps_to_do):
		current_walk_instruction = InstructionWalk.new()
		current_walk_instruction.direction = _object_to_instruct.facing_direction
		walk_instructions.append(current_walk_instruction)

	print(walk_instructions)
	after_consumed_callback(walk_instructions)
