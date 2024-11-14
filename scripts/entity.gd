extends CharacterBody2D
class_name Entity


@export var sprite : AnimatedSprite2D = null
@export var moveable_component : Moveable = null
@export var raycast: RayCast2D = null


var current_state : State
var facing_direction : Vector2i = Vector2i(0, 1)


func _ready() -> void:
	pass
