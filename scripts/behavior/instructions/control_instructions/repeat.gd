extends Instruction
class_name InstructionRepeat


@export var number_of_periods : int
@export var instructions : Array[Instruction]


var instructions_to_process : Array[Instruction] = []


func _ready() -> void:
	for i in number_of_periods:
		instructions_to_process.append_array(instructions)


func consume(_object_to_instruct : Entity) -> void:
	after_consumed_callback(instructions_to_process)
