extends Node2D


@onready var emotion_sprite: AnimatedSprite2D = %emotion_sprite
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


@export var offset : Vector2 = Vector2(0, -24)


const DURATION : float = 0.8


func _ready() -> void:
	global_position += offset


func play_emotion(emotion_name : String) -> void:
	emotion_sprite.visible = true
	audio_stream_player.play()
	emotion_sprite.play(emotion_name)
	await create_tween().tween_interval(DURATION).finished
	queue_free()
