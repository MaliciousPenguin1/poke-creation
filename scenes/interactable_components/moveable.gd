extends Node
class_name Moveable


const DEFAULT_MOVEMENT_DURATION : float = 1.0


var is_moving : bool = false
var facing_direction : Vector2i = Vector2i(0, 1)


func _ready() -> void:
	await owner.ready


func move(direction : Vector2, movement_duration : float = DEFAULT_MOVEMENT_DURATION) -> void: 
	var tween = create_tween()
	tween.tween_property(owner, "position", owner.position + direction*GlobalConstants.TILES_SIZE, movement_duration)
	tween.tween_callback(finish_movement)
	is_moving = true


func turn(direction : Vector2i) -> void:
	facing_direction = direction


func finish_movement() -> void:
	is_moving = false
	owner.current_state.after_walk()


func can_move() -> bool:
	return !is_moving
