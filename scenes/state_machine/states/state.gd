extends Node
class_name State


var state_machine : StateMachine = null


func enter(_message : Dictionary = {}) -> void:
	pass


func unhandled_input(_event: InputEvent) -> void:
	pass


func process(_delta: float) -> void:
	pass


func physics_process(_delta: float) -> void:
	pass


func exit() -> void:
	pass
