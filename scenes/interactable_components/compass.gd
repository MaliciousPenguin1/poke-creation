extends Node
class_name Compass

@export var instructions : Array[Compass_Instruction]
@export var periodical : bool = false
@export var wait_between_instructions : float = 0

var current_instruction_index : int = 0
var processing_instruction : bool = false


func _ready() -> void:
	await owner.ready
	for child in get_children():
		if child is Compass_Instruction:
			child.consumed.connect(_on_instruction_consumed)
	
	execute_next_instruction()


func execute_next_instruction() -> void:
	instructions[current_instruction_index].consume(owner)


func _on_instruction_consumed() -> void:
		current_instruction_index = current_instruction_index + 1
		current_instruction_index = current_instruction_index % len(instructions) if periodical else current_instruction_index
		if current_instruction_index < len(instructions):
			if wait_between_instructions > 0:
				await get_tree().create_timer(wait_between_instructions).timeout
			execute_next_instruction()
