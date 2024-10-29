extends Node
class_name StateMachine


##State machine based on the one from GDQuest.
##@tutorial:https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/


signal transitioned(state_name)


@export var initial_state : State


@onready var state : State = initial_state


func _ready() -> void:
	await owner.ready
	for child in get_children():
		child.state_machine = self
	state.enter()


func _unhandled_input(event: InputEvent) -> void:
	state.unhandled_input(event)


func _process(delta: float) -> void:
	state.process(delta)


func _physics_process(delta: float) -> void:
	state.physics_process(delta)


func transition_to(target_state_name : String, message : Dictionary = {}) -> void:
	if not has_node(target_state_name):
		push_error("The state machine associated with " + owner.name + " doesn't have a state named \"" + target_state_name + "\".")
		return
	
	state.exit()
	state = get_node(target_state_name)
	state.enter(message)
	transitioned.emit(state.name)
