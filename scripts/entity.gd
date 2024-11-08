extends CharacterBody2D
class_name Entity


@onready var moveable_component : Moveable = $Moveable
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast: RayCast2D = $RayCast2D


var current_state : State
var facing_direction : Vector2i = Vector2i(0, 1)
