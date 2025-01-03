extends State
class_name NpcState


const DIRECTIONS : Dictionary = {
	Vector2i(-1,0) : "Left",
	Vector2i(-1,-1) : "UpLeft",
	Vector2i(-1,1) : "DownLeft",
	Vector2i(1,0) : "Right",
	Vector2i(1,-1) : "UpRight",
	Vector2i(1,1) : "DownRight",
	Vector2i(0,-1) : "Up",
	Vector2i(0,1) : "Down"
}


@export var animation_name : String


var callback
var owner_object : Entity


func _ready() -> void:
	await owner.ready
	owner_object = owner as Entity
	assert(owner_object != null, "The owner of this state isn't of type \"Entity\".")


func enter(_message : Dictionary = {}) -> void:
	if animation_name:
		if owner_object.sprite.animation != animation_name + DIRECTIONS[owner_object.facing_direction]:
			owner_object.sprite.play(animation_name + DIRECTIONS[owner_object.facing_direction])

	if owner_object.raycast != null:
		owner_object.raycast.target_position = owner_object.facing_direction * GlobalConstants.TILES_SIZE
		owner_object.raycast.force_raycast_update()
	
	if owner_object.trainer_raycast != null:
		owner_object.trainer_raycast.target_position = owner_object.facing_direction * owner_object.trainer_detection_range*GlobalConstants.TILES_SIZE
