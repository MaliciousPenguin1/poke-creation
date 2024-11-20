extends Node2D
class_name WorldParent


var current_map : Map
var current_chunk : Chunk
var status : ResourceLoader.ThreadLoadStatus
var scene_name : String
var scene : Resource
var instanciated_scene : Node2D
var wait_frame_between_next_loading = 0


func _process(_delta : float) -> void:
	if wait_frame_between_next_loading == 0:
		for loading_map_id in Maplinker.BEING_LOADED_MAP_IDS.keys():
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
					wait_frame_between_next_loading = GlobalConstants.WAIT_BETWEEN_TWO_MAP_LOADS
					return
	else:
		wait_frame_between_next_loading -= 1
