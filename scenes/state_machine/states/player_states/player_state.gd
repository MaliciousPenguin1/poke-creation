extends State
class_name PlayerState


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


var player : Player


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The owner of this state isn't of type \"Player\".")
	player.current_state = self


func enter(_message : Dictionary = {}) -> void:
	if animation_name:
		player.sprite.play(animation_name + DIRECTIONS[player.facing_direction])
