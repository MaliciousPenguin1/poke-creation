extends CharacterBody2D
class_name Entity


@export var sprite : AnimatedSprite2D = null
@export var moveable_component : Moveable = null
@export var raycast: RayCast2D = null
@export var state_machine: StateMachine = null


signal finished_bumping


var facing_direction : Vector2i = Vector2i(0, 1)
var current_chunk : Chunk
var original_map_id : int
