extends Instruction
class_name InstructionIf


@export var condition_func : String
@export var args_for_condition_func : Dictionary = {}
@export var instructions : Array[Instruction] = []
@export var else_instructions : Array[Instruction] = []


var instructions_to_process : Array[Instruction]
var current_index : int
var current_object


func _ready() -> void:
	super()
	for child in instructions:
		assert(child is Instruction, "If node's child should be a Instruction!")
		child.consumed.connect(_on_instruction_consumed)
	for child in else_instructions:
		assert(child is Instruction, "If node's child should be a Instruction!")
		child.consumed.connect(_on_instruction_consumed)


func consume(_object_to_instruct) -> void:
	current_index = 0
	current_object = _object_to_instruct

	var evaluation : bool = Callable(_object_to_instruct, condition_func).call(args_for_condition_func)
	instructions_to_process = instructions if evaluation else else_instructions

	if len(instructions_to_process) > 0:
		instructions_to_process[0].consume(current_object)
	else:
		after_consumed_callback()


func _on_instruction_consumed() -> void:
	current_index += 1
	if current_index == len(instructions_to_process):
		return after_consumed_callback()

	instructions_to_process[current_index].consume(current_object)
