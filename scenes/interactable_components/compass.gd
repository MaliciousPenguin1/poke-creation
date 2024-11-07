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
	
	var timer : Timer = get_children(true).filter(func(n) : return n.name == 'Timer')[0]
	if wait_between_instructions > 0:
		timer.wait_time = wait_between_instructions
	timer.timeout.connect(_on_timer_timeout)
	
	instructions[0].consume(owner)


func _on_timer_timeout() -> void:
	print(instructions[current_instruction_index])
	instructions[current_instruction_index].consume(owner)


func _on_instruction_consumed() -> void:
		current_instruction_index = current_instruction_index + 1
		current_instruction_index = current_instruction_index % len(instructions) if periodical else current_instruction_index
		if current_instruction_index < len(instructions):
			if wait_between_instructions > 0:
				var timer : Timer = get_children(true).filter(func(n) : return n.name == 'Timer')[0]
				timer.start()
			else:
				_on_timer_timeout()
