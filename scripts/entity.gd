extends CharacterBody2D
class_name Entity


var sprite : AnimatedSprite2D = null
var moveable_component : Moveable = null
var raycast: RayCast2D = null


var current_state : State
var facing_direction : Vector2i = Vector2i(0, 1)


func _ready() -> void:
	var moveable_component_candidates = find_children("*", "Moveable", false)
	assert(len(moveable_component_candidates) < 2, "The Entity class cannot have more then one Moveable children")
	if len(moveable_component_candidates) == 1:
		moveable_component = moveable_component_candidates[0]
	
	var raycast_candidates = find_children("*", "RayCast2D", false)
	assert(len(raycast_candidates) < 2, "The Entity class cannot have more then one direct RayCst2D children")
	if len(raycast_candidates) == 1:
		raycast = raycast_candidates[0]
		
	var sprite_candidates = find_children("*", "AnimatedSprite2D", false)
	sprite = sprite_candidates[0]
