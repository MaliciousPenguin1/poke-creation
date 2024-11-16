extends NpcState
class_name NpcStateWalk


var direction : Vector2i
var need_to_collide_if_cant_move : bool
var callback_in_case_of_collision


func enter(_message : Dictionary = {}) -> void:
	super()
	callback = _message["callback"] if _message.has("callback") else null
	if _message.has("need_to_collide_if_cant_move"):
		need_to_collide_if_cant_move = _message["need_to_collide_if_cant_move"]
		callback_in_case_of_collision = _message["callback_in_case_of_collision"] if _message.has("callback_in_case_of_collision") else _message["callback"]
	else:
		need_to_collide_if_cant_move = true
	direction = _message["direction"]


	var target_position : Vector2i = Vector2i(owner.global_position) + (direction * GlobalConstants.TILES_SIZE)
	if owner.moveable_component.can_walk_towards(target_position):
		owner.moveable_component.move(direction, target_position)
	else:
		if need_to_collide_if_cant_move:
			state_machine.transition_to("NpcStateColliding", {"target_position" : target_position, "target_direction" : direction, "callback" : callback})
		else:
			after_walk_collision()


func after_walk() -> void:
	state_machine.transition_to("NpcStateIdle")
	if callback:
		callback.call()


func after_walk_collision() -> void:
	state_machine.transition_to("NpcStateIdle")
	if callback_in_case_of_collision:
		callback_in_case_of_collision.call()
