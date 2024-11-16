extends NpcState
class_name NpcStateColliding


var target_position : Vector2i
var target_direction : Vector2i


func _ready() -> void:
	await super()
	owner.finished_bumping.connect(_on_finished_bumping)


func enter(_message : Dictionary = {}) -> void:
	print(_message)
	super()
	callback = _message["callback"] if _message.has("callback") else null
	target_position = _message["target_position"]
	target_direction = _message["target_direction"]
	owner.moveable_component.initiate_collision()


func _on_finished_bumping() -> void:
	print("try collsion ", owner)
	if owner.moveable_component.can_walk_towards(target_position):
		print("success")
		state_machine.transition_to("NpcStateWalk", {"direction" : target_direction, "callback" : callback})
	else:
		print("failed")
		owner.moveable_component.initiate_collision()
