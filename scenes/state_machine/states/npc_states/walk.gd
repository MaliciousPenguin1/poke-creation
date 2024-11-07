extends NpcState
class_name NpcStateWalk

var direction : Vector2i


func enter(_message : Dictionary = {}) -> void:
	super()
	callback = _message["callback"] if _message.has("callback") else null
	direction = _message["direction"]
	owner.moveable_component.move(direction)


func after_walk() -> void:
	state_machine.transition_to("NpcStateIdle")
	if callback:
		callback.call()
