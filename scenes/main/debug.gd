extends Node



##Temporaire, juste pour faire des tests.


func _ready() -> void:
	await get_tree().physics_frame
	ScenesManager.add_scene("res://scenes/overworld/player/Player.tscn", ScenesManager.SceneType.SCENE_2D)
