extends Node
class_name Behavior


@export var ready_instructions_handler : ReadyInstructionsHandler = null
@export var process_instructions_handler : ProcessInstructionsHandler = null
@export var bump_instructions_handler : BumpInstructionsHandler = null
@export var interact_instructions_handler : InteractInstructionsHandler = null


func _ready() -> void:
	await owner.ready
	if ready_instructions_handler != null:
		ready_instructions_handler.execute_next_instruction()


func _process(delta: float) -> void:
	if process_instructions_handler != null:
		process_instructions_handler.finished = false
		process_instructions_handler.execute_next_instruction()
		while !process_instructions_handler.finished:
			pass
