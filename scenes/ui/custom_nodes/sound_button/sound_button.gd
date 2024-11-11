@tool
extends Button
class_name SoundButton


@export var hover_sound : AudioStream

@export var click_sound : AudioStream

@export var disabled_sound : AudioStream


func _on_pressed() -> void:
	if disabled and disabled_sound != null:
		_play_audio(disabled_sound)
	elif click_sound!= null:
		_play_audio(click_sound)


func _on_mouse_entered() -> void:
	grab_focus()


func _on_focus_entered() -> void:
	if hover_sound != null:
		_play_audio(hover_sound)


func _play_audio(audio : AudioStream) -> void:
	var audio_player : AudioStreamPlayer = AudioStreamPlayer.new()
	audio_player.bus = "Sounds"
	audio_player.stream = audio
	
	add_child(audio_player)
	audio_player.play()
	await audio_player.finished
	audio_player.queue_free()
