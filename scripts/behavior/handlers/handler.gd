extends Node
class_name Handler


@export var instructions : Array[Instruction]
@export var periodical : bool = false
@export var wait_between_instructions : float = 0


var current_instruction_index : int = 0
var finished : bool = false


func _ready() -> void:
	for child in instructions:
		if child is Instruction and !child.consumed.is_connected(_on_instruction_consumed):
			child.consumed.connect(_on_instruction_consumed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func execute_next_instruction() -> void:
	instructions[current_instruction_index].consume(owner)


func _on_instruction_consumed() -> void:
		current_instruction_index = current_instruction_index + 1
		current_instruction_index = current_instruction_index % len(instructions) if periodical else current_instruction_index
		if current_instruction_index < len(instructions):
			if wait_between_instructions > 0:
				await get_tree().create_timer(wait_between_instructions, false).timeout
			execute_next_instruction()
		else:
			finished = true
