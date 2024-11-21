extends Node
class_name Instruction


signal consumed


func _ready() -> void:
	pass # Replace with function body.


func consume(_object_to_instruct) -> void:
	pass


func after_consumed_callback(instructions_to_insert : Array[Instruction] = [], handlers_to_pause : Array[Behavior.HANDLERS] = [], priority_instructions_to_insert : Array[Instruction] = []) -> void:
	consumed.emit(instructions_to_insert, handlers_to_pause, priority_instructions_to_insert)
