extends Node



##Temporaire, juste pour faire des tests.


func _ready() -> void:
	await owner.ready
	ScenesManager.add_scene("res://scenes/overworld/player/Player.tscn", ScenesManager.SceneType.ENTITY, Vector2i(3,5))
	ScenesManager.add_scene("res://scenes/overworld/npc/professor.tscn", ScenesManager.SceneType.ENTITY, Vector2i(6, 5))
	ScenesManager.add_scene("res://scenes/overworld/worlds/maps/collisions_debug_map.tscn", ScenesManager.SceneType.WORLD)
