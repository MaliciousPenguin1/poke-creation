extends Node


##An autoload to add and remove 2D and UI scenes to the main one. 


enum SceneType {WORLD, UI, ENTITY}


@onready var main : Main = get_tree().root.get_child(-1)


func add_map_scene_neighbours(map_id : int, original_map_coordinates : Vector2i) -> void:
			var neighbour_ids : Array = Maplinker.get_neighbours_ids(map_id)
			var currently_loaded_map_ids : Array = Maplinker.get_currently_loaded_map_ids().duplicate()
			
			var scene_to_free : Node2D
			for loaded_map_id in currently_loaded_map_ids:
				print("CHECKING FOR UNLOADING ", loaded_map_id)
				if loaded_map_id != map_id and !(loaded_map_id in neighbour_ids):
					print("UNLOADING ", loaded_map_id)
					scene_to_free = main.world_parent.find_children("*", "", false).filter(func(s): return s.id == loaded_map_id)[0]
					scene_to_free.queue_free()
					Maplinker.register_unloaded(loaded_map_id)

			var current_neighbour_id : int
			var current_neighbour_offset : Vector2i
			var neighbour_scene : Node2D
			
			for neighbour_data in Maplinker.get_neighbours_data(map_id):
				current_neighbour_id = neighbour_data[0]
				current_neighbour_offset = neighbour_data[1]
				if !Maplinker.is_already_loaded(current_neighbour_id):
					print("LOADING ", current_neighbour_id)
					neighbour_scene = load(Maplinker.get_scene_resource_name(current_neighbour_id)).instantiate()
					neighbour_scene.global_position = original_map_coordinates + current_neighbour_offset
					main.world_parent.add_child(neighbour_scene)
					neighbour_scene.owner = main.world_parent
					Maplinker.register_loaded(current_neighbour_id)
				else:
					print(current_neighbour_id, " IS ALREADY LOADED")


func add_map_scene(map_id : int) -> void:
	var map_scene = load(Maplinker.get_scene_resource_name(map_id)).instantiate()
	map_scene.global_position = Vector2i(0, 0)
	main.world_parent.add_child(map_scene)
	map_scene.owner = main.world_parent
	Maplinker.register_loaded(map_id)


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
