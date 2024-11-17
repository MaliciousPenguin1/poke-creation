extends Node


##An autoload to add and remove 2D and UI scenes to the main one. 


enum SceneType {WORLD, UI, ENTITY}


@onready var main : Main = get_tree().root.get_child(-1)


func load_map(map_id : int, pos : Vector2i = Vector2i(0, 0)) -> void:
	var scene : Node2D = load(Maplinker.get_scene_resource_name(map_id)).instantiate()
	scene.global_position = pos
	for chunk in scene.chunks:
		Maplinker.register_chunk(chunk)
	main.world_parent.add_child(scene)
	scene.owner = main.world_parent
	Maplinker.register_loaded(map_id)


# Unloads every map which isn' tthe neighbout of the given map
func unload_unnecessary_maps(map_id : int) -> void:
	var neighbour_ids : Array = Maplinker.get_neighbours_ids(map_id)
	var currently_loaded_map_ids : Array = Maplinker.get_currently_loaded_map_ids().duplicate()

	var scene_to_free : Node2D
	for loaded_map_id in currently_loaded_map_ids:
		if loaded_map_id != map_id and !(loaded_map_id in neighbour_ids):
			scene_to_free = main.world_parent.find_children("*", "", false).filter(func(s): return s.id == loaded_map_id)[0]
			for chunk in scene_to_free.chunks:
				Maplinker.unregister_chunk(chunk)
			for entity in scene_to_free.entities.get_children():
				Maplinker.remove_entity_from_chunk(entity)
			scene_to_free.queue_free()
			Maplinker.register_unloaded(loaded_map_id)


# Loads and places the neighbours of a given map in the world and unloads the unnecessary maps
func add_map_scene_neighbours(map_id : int, original_map_coordinates : Vector2i) -> void:
	unload_unnecessary_maps(map_id)

	var current_neighbour_id : int
	var current_neighbour_offset : Vector2i

	for neighbour_data in Maplinker.get_neighbours_data(map_id):
		current_neighbour_id = neighbour_data[0]
		current_neighbour_offset = neighbour_data[1]
		if !Maplinker.is_already_loaded(current_neighbour_id):
			load_map(current_neighbour_id, original_map_coordinates + GlobalConstants.TILES_SIZE*GlobalConstants.CHUNK_SIZE*current_neighbour_offset)


# Loads a new map inside the world and unloads every map which isnt connected to this map
func add_new_map_scene(map_id : int) -> void:
	unload_unnecessary_maps(map_id)
	load_map(map_id)


##Adds a scene to the main one.
func add_scene(scene_path : String, scene_type : SceneType, coordinates : Vector2i = Vector2i.ZERO) -> void:
	var final_position : Vector2i = coordinates * GlobalConstants.TILES_SIZE
	
	match scene_type:
		SceneType.WORLD:
			print("Cannot Load WORLD from here")
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
		SceneType.WORLD:
			var node_to_remove : Node2D = get_node(str(main.world_parent.get_path()) + "/" + scene_name)
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
