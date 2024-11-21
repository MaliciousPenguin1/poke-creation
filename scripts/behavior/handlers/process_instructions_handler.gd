extends Handler
class_name ProcessInstructionsHandler


var instructions_to_add : Array[Instruction] = []


func _ready() -> void:
	super()
	
	for child in instructions:
		assert(child is ParallelInstruction, "ProcessInstructionsHandler child should be a ParallelInstruction")
		if !child.consumed.is_connected(_on_instruction_consumed):
			child.consumed.connect(_on_instruction_consumed)
