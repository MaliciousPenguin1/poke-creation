extends CharacterBody2D
class_name Entity


@export var sprite : AnimatedSprite2D = null
@export var moveable_component : Moveable = null
@export var raycast: RayCast2D = null
@export var state_machine: StateMachine = null
@export_subgroup("Trainer Infos")
@export var trainer_detection_range : int = 1
@export var trainer_raycast : RayCast2D = null


signal finished_bumping


var facing_direction : Vector2i = Vector2i(0, 1)
