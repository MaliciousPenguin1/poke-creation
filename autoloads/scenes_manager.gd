extends Node


##An autoload to add and remove 2D and UI scenes to the main one. 


enum SceneType {MAP, UI, ENTITY}


@onready var main : Main = get_tree().root.get_child(-1)


static var current_world_layout : WorldLayoutData


##Adds a scene to the main one.
func add_scene(scene_path : String, scene_type : SceneType, coordinates : Vector2i = Vector2i.ZERO) -> void:
	var final_position : Vector2i = coordinates * GlobalConstants.TILES_SIZE
	
	match scene_type:
		SceneType.MAP:
			var scene : Map = load(scene_path).instantiate()
			scene.global_position = final_position
			main.world.add_child(scene)
		SceneType.ENTITY:
			var scene : Node2D = load(scene_path).instantiate()
			final_position.x += GlobalConstants.TILES_SIZE / 2
			final_position.y += GlobalConstants.TILES_SIZE / 2
			scene.global_position = final_position
			main.world_parent.add_child(scene)
		SceneType.UI:
			var scene : Control = load(scene_path).instantiate()
			scene.global_position = coordinates
			main.ui_parent.add_child(scene)


##Removes a scene from the main one. Providing a scene type isn't necessary but it is recommended.
func remove_scene(scene_name : String, scene_type : SceneType) -> void:
	match scene_type:
		SceneType.MAP:
			var node_to_remove : Node2D = get_node(str(main.world.get_path()) + "/" + scene_name)
			if node_to_remove:
				node_to_remove.queue_free()
			GlobalVar.reserved_tiles.clear()
		SceneType.ENTITY:
			var node_to_remove : Node2D = get_node(str(main.world_parent.get_path()) + "/" + scene_name)
			if node_to_remove:
				node_to_remove.queue_free()
		SceneType.UI:
			var node_to_remove : Control = get_node(str(main.ui_parent.get_path()) + "/" + scene_name)
			if node_to_remove:
				node_to_remove.queue_free()
		_:
			var node_to_remove := main.find_child(scene_name)
			if node_to_remove:
				node_to_remove.queue_free()


##Show the pause menu
func show_pause_menu() -> void:
	if not GlobalVar.can_pause:
		return
	
	GameTime.stop_clock()
	get_tree().paused = true
	add_scene("res://scenes/ui/pause_menu/pause_menu.tscn", SceneType.UI)


##Adds a standalone map to the scene. If a world_layout_path is added, adds it i_n the context of a world instead.
func add_map(map_path : String, world_layout_path : String = "") -> void:
	if world_layout_path == "":
		add_scene(map_path, SceneType.MAP)
	else:
		if not ResourceLoader.exists(world_layout_path, "WorldLayoutData"):
			push_error("The path \"" + world_layout_path + "\" doesn't lead to a valid WorldLayoutData resource.")
			return
		
		current_world_layout = ResourceLoader.load(world_layout_path)
		if map_path not in current_world_layout.data.keys():
			push_error("The map at the path \"" + map_path + "\" isn't found in the world \"" + current_world_layout.resource_name +"\".")
			return
		
		call_deferred("_place_map_in_world", map_path)


func _place_map_in_world(map_path : String) -> void:
	var map : PackedScene = ResourceLoader.load(map_path)
	var map_instance : Map = map.instantiate()
	map_instance.name = current_world_layout.data[map_path]["map_name"]
	map_instance.global_position = current_world_layout.data[map_path]["position_in_world"]
	main.world.add_child(map_instance)


func on_map_entered(map_path : String) -> void:
	if current_world_layout == null:
		return
	
	var neighbors_already_loaded : PackedStringArray
	_remove_non_neighbors(map_path, neighbors_already_loaded)
	_add_neighbors(map_path, neighbors_already_loaded)


func _remove_non_neighbors(map_path : String, neighbors_already_loaded : PackedStringArray) -> void:
	for map in main.world.get_children():
		if map.scene_file_path in current_world_layout.data[map_path]["neighbors"] or map.scene_file_path == map_path:
			neighbors_already_loaded.append(map.scene_file_path)
		else:
			map.queue_free()


func _add_neighbors(map_path : String, neighbors_already_loaded : PackedStringArray) -> void:
	for neighbor in current_world_layout.data[map_path]["neighbors"]:
		if neighbor not in neighbors_already_loaded:
			call_deferred("_place_map_in_world", neighbor)


func erase_world() -> void:
	current_world_layout = null
	for child in main.world.get_children():
		queue_free()
