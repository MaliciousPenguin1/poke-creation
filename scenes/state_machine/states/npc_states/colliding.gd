extends NpcState
class_name NpcStateColliding


var target_position : Vector2i
var target_direction : Vector2i


func _ready() -> void:
	await super()
	owner_object.finished_bumping.connect(_on_finished_bumping)


func enter(_message : Dictionary = {}) -> void:
	super()
	callback = _message["callback"] if _message.has("callback") else null
	target_position = _message["target_position"]
	target_direction = _message["target_direction"]
	owner_object.moveable_component.initiate_collision()


func _on_finished_bumping() -> void:
	if owner_object.moveable_component.can_walk_towards(target_position):
		state_machine.transition_to("NpcStateWalk", {"direction" : target_direction, "callback" : callback})
	else:
		owner_object.moveable_component.initiate_collision()
