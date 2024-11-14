extends Handler
class_name ProcessInstructionsHandler


func _ready() -> void:
	super()
	
	for child in instructions:
		assert(child is Instruction, "ProcessInstructionsHandler child should be a Parallel Instruction")
