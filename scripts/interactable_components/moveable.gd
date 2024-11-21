extends Node
class_name Moveable


const DEFAULT_MOVEMENT_DURATION : float = 0.25


var is_moving : bool = false
var target_tile : Vector2i


var owner_object : Entity


func _ready() -> void:
	await owner.ready
	owner_object = owner as Entity
	assert(owner_object != null, "Moveable's owner should be an Entity!")


func move(direction : Vector2, target_position : Vector2i, movement_duration : float = DEFAULT_MOVEMENT_DURATION) -> void: 
	target_tile = target_position
	GlobalVar.reserved_tiles[target_position] = null
	
	var tween = create_tween()
	tween.tween_property(owner_object, "position", owner_object.position + direction*GlobalConstants.TILES_SIZE, movement_duration)
	tween.tween_callback(finish_movement)
	is_moving = true


func turn(direction : Vector2i) -> void:
	owner_object.facing_direction = direction


func finish_movement() -> void:
	if owner_object is Player:
		owner_object.movement_finished.emit()

	is_moving = false
	GlobalVar.reserved_tiles.erase(target_tile)
	owner_object.state_machine.state.after_walk()


func can_move() -> bool:
	return !is_moving


func initiate_collision(time_to_wait : float = DEFAULT_MOVEMENT_DURATION) -> void:
	if owner_object is Player:
		owner_object.play_colliding_sound()

	#await get_tree().create_timer(time_to_wait, false).timeout
	await create_tween().tween_interval(time_to_wait).finished
	owner_object.finished_bumping.emit()


func can_walk_towards(target_position : Vector2i) -> bool:
	return !target_position in GlobalVar.reserved_tiles and !owner_object.raycast.is_colliding()
