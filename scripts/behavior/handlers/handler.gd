extends Node
class_name Handler


@export var instructions : Array[Instruction]
@export var periodical : bool = false
@export var wait_between_instructions : float = 0


var finished : bool = false
var can_process : bool = true
var current_instructions : Array[Instruction] = []
var object_to_handle


signal need_to_interrupt_handlers
signal when_finished
signal need_to_start_priority_instructions


func _ready() -> void:
	if owner != null: #special case for priority handler for which we need to set this property manually
		object_to_handle = owner

	current_instructions = instructions.duplicate()
	current_instructions.reverse()
	
	for child in instructions:
		if !child.consumed.is_connected(_on_instruction_consumed):
			child.consumed.connect(_on_instruction_consumed)


func execute_next_instruction() -> void:
	if !can_process:
		await get_parent().restart_processing
	
	var instruction : Instruction = current_instructions.pop_back()
	if instruction != null:
		instruction.consume(object_to_handle)


func _on_instruction_consumed(instructions_to_insert : Array[Instruction] = [], handlers_to_pause : Array[Behavior.HANDLERS] = [], priority_instructions_to_insert : Array[Instruction] = []) -> void:
		if len(priority_instructions_to_insert) > 0:
			need_to_start_priority_instructions.emit(priority_instructions_to_insert)
		elif len(handlers_to_pause) > 0:
			need_to_interrupt_handlers.emit(handlers_to_pause)

		if !can_process:
			await get_parent().restart_processing
		
		if len(instructions_to_insert) > 0:
			for child in instructions_to_insert:
				if !child.consumed.is_connected(_on_instruction_consumed):
					child.consumed.connect(_on_instruction_consumed)

			instructions_to_insert.reverse()
			current_instructions.append_array(instructions_to_insert)			

		if len(current_instructions) > 0:
			if wait_between_instructions > 0:
				await create_tween().tween_interval(wait_between_instructions).finished
			execute_next_instruction()
		else:
			current_instructions = instructions.duplicate()
			current_instructions.reverse()
			if !periodical:
				finished = true
				when_finished.emit()
			else:
				if wait_between_instructions > 0:
					await create_tween().tween_interval(wait_between_instructions).finished
				execute_next_instruction()
