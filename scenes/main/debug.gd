extends Node


##Temporaire, juste pour faire des tests.


@onready var world_parent: Node2D = $"../WorldParent"
@onready var custom_camera: CustomCamera = $"../WorldParent/CustomCamera"


func _ready() -> void:
	await owner.ready
	ScenesManager.add_scene("res://scenes/overworld/player/Player.tscn", ScenesManager.SceneType.ENTITY, Vector2i(3,5))
	#ScenesManager.add_scene("res://scenes/overworld/npc/professor.tscn", ScenesManager.SceneType.ENTITY, Vector2i(6, 5))
	ScenesManager.add_scene("res://scenes/overworld/worlds/maps/collision_debug/npc1.tscn", ScenesManager.SceneType.ENTITY, Vector2i(4, 8))
	ScenesManager.add_scene("res://scenes/overworld/worlds/maps/collision_debug/npc2.tscn", ScenesManager.SceneType.ENTITY, Vector2i(6, 8))
	ScenesManager.add_scene("res://scenes/overworld/worlds/maps/collision_debug/collisions_debug_map.tscn", ScenesManager.SceneType.WORLD)
	
	custom_camera.reparent(world_parent.get_child(1))
	custom_camera.move_to_parent()
