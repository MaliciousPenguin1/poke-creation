extends CharacterBody2D
class_name Player

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast : RayCast2D = $RayCast2D
@onready var moveable_component : Moveable = $Moveable

var current_state : State
