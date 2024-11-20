extends Instruction
class_name InstructionCallFunc

@export var func_name : String
@export var args : Dictionary


func consume(_object_to_instruct) -> void:
	Callable(_object_to_instruct, func_name).call(args)
	after_consumed_callback()
