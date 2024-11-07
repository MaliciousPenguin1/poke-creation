extends NpcState
class_name NpcStateWalk

var direction : Vector2i

var target_position : Vector2i


func enter(_message : Dictionary = {}) -> void:
	super()
	callback = _message["callback"] if _message.has("callback") else null
	direction = _message["direction"]
	
	target_position = Vector2i(owner.global_position) + (direction * GlobalConstants.TILES_SIZE)
	if target_position in GlobalVar.reserved_tiles or owner.raycast.is_colliding():
		state_machine.transition_to("NpcStateIdle")
	else:
		owner.moveable_component.move(direction)
		GlobalVar.reserved_tiles.append(target_position)


func after_walk() -> void:
	GlobalVar.reserved_tiles.erase(target_position)
	
	state_machine.transition_to("NpcStateIdle")
	if callback:
		callback.call()
