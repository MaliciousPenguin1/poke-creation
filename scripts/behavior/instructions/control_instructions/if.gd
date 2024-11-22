extends Instruction
class_name InstructionIf


@export var condition_func : String
@export var args_for_condition_func : Dictionary = {}
@export var instructions : Array[Instruction] = []
@export var else_instructions : Array[Instruction] = []


var instructions_to_process : Array[Instruction]


func consume(_object_to_instruct : Entity) -> void:
	var evaluation : bool = Callable(_object_to_instruct, condition_func).call(args_for_condition_func)
	instructions_to_process = instructions if evaluation else else_instructions
	after_consumed_callback(instructions_to_process.duplicate())
