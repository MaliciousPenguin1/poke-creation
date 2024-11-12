extends Node
class_name Moveable


const DEFAULT_MOVEMENT_DURATION : float = 0.25


var is_moving : bool = false

var target_tile : Vector2i


func _ready() -> void:
	await owner.ready


func move(direction : Vector2, target_position : Vector2i, movement_duration : float = DEFAULT_MOVEMENT_DURATION) -> void: 
	target_tile = target_position
	GlobalVar.reserved_tiles[target_position] = null
	
	var tween = create_tween()
	tween.tween_property(owner, "position", owner.position + direction*GlobalConstants.TILES_SIZE, movement_duration)
	tween.tween_callback(finish_movement)
	is_moving = true


func turn(direction : Vector2i) -> void:
	owner.facing_direction = direction


func finish_movement() -> void:
	is_moving = false
	GlobalVar.reserved_tiles.erase(target_tile)
	owner.current_state.after_walk()


func can_move() -> bool:
	return !is_moving
