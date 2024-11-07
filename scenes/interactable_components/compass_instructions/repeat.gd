extends Compass_Instruction
class_name Compass_Instruction_Repeat


@export var number_of_periods : int


var current_index
var current_period
var current_object


func _ready() -> void:
	super()
	for child in get_children():
		assert(child is Compass_Instruction, "Repeat node's child should be a Compass_Instruction!")
		child.consumed.connect(_on_instruction_consumed)


func consume(_object_to_instruct) -> void:
		if len(get_children()) > 0:
			current_index = 0
			current_period = 0
			current_object = _object_to_instruct
			get_children()[0].consume(current_object)


func _on_instruction_consumed() -> void:
		var childs = get_children()

		current_index += 1
		if current_index == len(childs):
			current_period += 1

			if current_period >= number_of_periods:
				return after_consumed_callback()
			else:
				current_index = 0
		
		childs[current_index].consume(current_object)
