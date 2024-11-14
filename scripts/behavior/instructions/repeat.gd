extends Instruction
class_name Instruction_Repeat


@export var number_of_periods : int
@export var instructions : Array[Instruction]


var current_index
var current_period
var current_object


func _ready() -> void:
	super()
	for child in instructions:
		assert(child is Instruction, "Repeat node's child should be a Instruction!")
		child.consumed.connect(_on_instruction_consumed)


func consume(_object_to_instruct) -> void:
		if len(instructions) > 0:
			current_index = 0
			current_period = 0
			current_object = _object_to_instruct
			instructions[0].consume(current_object)


func _on_instruction_consumed() -> void:
		current_index += 1
		if current_index == len(instructions):
			current_period += 1

			if current_period >= number_of_periods:
				return after_consumed_callback()
			else:
				current_index = 0
		
		instructions[current_index].consume(current_object)
