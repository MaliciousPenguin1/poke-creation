extends Node2D
class_name WorldParent


var current_map : Map
var current_chunk : Chunk


func _process(_delta : float) -> void:
	var status : ResourceLoader.ThreadLoadStatus
	var scene_name : String
	var scene : Resource
	var instanciated_scene : Node2D
	var need_to_update_chunks : bool = false

	for loading_map_id in Maplinker.BEING_LOADED_MAP_IDS.keys():
		print(Maplinker.BEING_LOADED_MAP_IDS)
		scene_name = Maplinker.get_scene_resource_name(loading_map_id)
		status = ResourceLoader.load_threaded_get_status(scene_name)

		match status:
			ResourceLoader.THREAD_LOAD_INVALID_RESOURCE or ResourceLoader.THREAD_LOAD_FAILED:
				push_error("Failed to load map ", loading_map_id, ". The statue is ", status)
			ResourceLoader.THREAD_LOAD_LOADED:
				scene = ResourceLoader.load_threaded_get(scene_name)
				instanciated_scene = scene.instantiate()
				ScenesManager.place_the_loaded_map_in_the_world(instanciated_scene, Maplinker.BEING_LOADED_MAP_IDS[loading_map_id])
				Maplinker.BEING_LOADED_MAP_IDS.erase(loading_map_id)
				Maplinker.refresh_chunks(current_chunk)
				return
		
		if need_to_update_chunks:
			Maplinker.refresh_chunks(current_chunk)
