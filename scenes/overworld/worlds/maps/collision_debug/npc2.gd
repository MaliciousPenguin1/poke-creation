extends CharacterBody2D


@onready var moveable_component : Moveable = $Moveable
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast: RayCast2D = $RayCast2D


var current_state
