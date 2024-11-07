extends NpcState
class_name NpcStateWalk

var direction : Vector2i


func enter(_message : Dictionary = {}) -> void:
	super()
	callback = _message["callback"] if _message.has("callback") else null
	direction = _message["direction"]
	
	var target_position : Vector2i = Vector2i(owner.global_position) + direction
	if target_position in GlobalVar.reserved_tiles:
		state_machine.transition_to("NpcStateIdle")
	else:
		owner.moveable_component.move(direction)


func after_walk() -> void:
	GlobalVar.reserved_tiles.erase(Vector2i(owner.global_position))
	
	state_machine.transition_to("NpcStateIdle")
	if callback:
		callback.call()
