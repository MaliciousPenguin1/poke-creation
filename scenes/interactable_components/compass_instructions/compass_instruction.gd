extends Node
class_name Compass_Instruction


signal consumed


func _ready() -> void:
	pass # Replace with function body.


func consume(_object_to_instruct) -> void:
	pass


func after_consumed_callback() -> void:
	consumed.emit()
