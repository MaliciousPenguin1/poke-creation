extends Node2D
class_name Map


#The Chunk Areas of the map
@export var chunks : Array[Chunk] = []
#Neighbor maps
@export var id : int
##The name of the map (or its key in a csv translation file).
@export var map_name : String = "Placeholder"
##The bgm of this map.
@export var bgm : AudioStream
##Wether the player can fly here using the "Fly" HM or something equivalent.
@export var can_fly_here : bool = false
##The coordinates of the position where the player ends up after flying to this map.
@export var flying_coordinates : Vector2i

##List of the Pokémon species that can be encountered on this map.[br]
##To learn moer about Pokémon encounters, go to [url]https://bulbapedia.bulbagarden.net/wiki/Wild_Pok%C3%A9mon[/url].
@export_group("Encounters")
##Regular random encounters that happen it tall grass or caves.
@export var regular_encounters : Array[Encounters]
##Regular random encounters that happen it tall grass or caves during the night.[br]
##If left empty, the night encounters will be the same as the ones happening during the rest of the day.
@export var regular_encounters_night : Array[Encounters]
##The encounters that can happen while swimming.
@export var swimming : Array[Encounters]
##The encounters that can happen while fishing.
@export_subgroup("Fishing")
##The encounters that can happen when fishing with an old rod.
@export var old_rod_encounters : Array[Encounters]
##The encounters that can happen when fishing with a good rod.
@export var good_rod_encounters : Array[Encounters]
##The encounters that can happen when fishing with a super rod.
@export var super_rod_encounters : Array[Encounters]


func _ready() -> void:
	for chunk in chunks:
		chunk.body_entered.connect(_on_chunk_entered.bind(chunk), 1)


func _on_chunk_entered(body : Node2D, chunk : Chunk) -> void:
	if body is Player:
		owner.current_chunk = chunk
		Maplinker.find_and_activate_neighbour_chunks(chunk)
		if owner.current_map != self:
			print("changing map ", self, " pos ", position, " global pos ", global_position)
			print(Maplinker.LOADED_CHUNKS)
			owner.current_map = self
			ScenesManager.add_map_scene_neighbours(id, global_position)
	elif body is Entity:
		print("NPC")
		Maplinker.register_entity_in_chunk(chunk, body)
		if !chunk.need_to_process:
			print("STOPPING NPC")
			body.set_process_mode(4)


#func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	#GlobalVar.reserved_tiles.clear()
