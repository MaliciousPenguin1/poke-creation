extends Node
class_name Behavior


enum HANDLERS { READY, PROCESS, BUMP, INTERACT }


@export var ready_instructions_handler : ReadyInstructionsHandler = null
@export var process_instructions_handler : ProcessInstructionsHandler = null
@export var bump_instructions_handler : BumpInstructionsHandler = null
@export var interact_instructions_handler : InteractInstructionsHandler = null


var owner_object : Entity
var priority_handler : Handler #Handler used to override dynamically other handler's instructions (trainer, ...)
@onready var HANDLERS_CORRESPONDANCE_TABLE : Dictionary = {
	HANDLERS.READY: ready_instructions_handler,
	HANDLERS.PROCESS: process_instructions_handler,
	HANDLERS.BUMP: bump_instructions_handler,
	HANDLERS.INTERACT: interact_instructions_handler,
}


signal restart_processing


func _ready() -> void:
	await owner.ready
	owner_object = owner as Entity
	assert(owner_object != null, "Moveable's owner should be an Entity!")

	priority_handler = Handler.new()
	priority_handler.object_to_handle = owner_object
	
	for handler in [ready_instructions_handler, process_instructions_handler, bump_instructions_handler, interact_instructions_handler]:
		if handler != null:
			handler.need_to_interrupt_handlers.connect(pause_handlers)
			handler.need_to_start_priority_instructions.connect(start_priority_instructions)

	if ready_instructions_handler != null:
		ready_instructions_handler.execute_next_instruction()


func _process(delta: float) -> void:
	if process_instructions_handler != null and process_instructions_handler.can_process:
		process_instructions_handler.finished = false
		process_instructions_handler.execute_next_instruction()
		while !process_instructions_handler.finished and process_instructions_handler.can_process:
			pass


func pause_handlers(handlers : Array[HANDLERS]):
	var handler_vars : Array[Handler] = map_handler_sym_to_handler(handlers)
	
	for handler in handler_vars:
			if handler != null:
				handler.can_process = false


func unpause_handlers(handlers : Array[HANDLERS]):
	var handler_vars : Array[Handler] = map_handler_sym_to_handler(handlers)

	for handler in handler_vars:
			if handler != null:
				handler.can_process = true
	restart_processing.emit()


func start_priority_instructions(instructions : Array[Instruction]) -> void:
	pause_handlers([HANDLERS.READY, HANDLERS.PROCESS, HANDLERS.BUMP, HANDLERS.INTERACT])
	
	priority_handler.instructions = instructions
	priority_handler._ready()
	priority_handler.execute_next_instruction()
	
	await priority_handler.when_finished
	
	unpause_handlers([HANDLERS.READY, HANDLERS.PROCESS, HANDLERS.BUMP, HANDLERS.INTERACT])


func map_handler_sym_to_handler(handlers : Array[HANDLERS]) -> Array[Handler]:
	var output : Array[Handler] = []
	for handler_enum in handlers:
		output.append(HANDLERS_CORRESPONDANCE_TABLE[handler_enum])
	return output
