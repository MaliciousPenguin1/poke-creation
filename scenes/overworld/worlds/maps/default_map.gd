extends Node2D
class_name Map


@onready var entities: Node2D = $Entities


#The Chunk Areas of the map
@export var chunks : Array[Chunk] = []
#Neighbor maps
@export var id : int
#BG Music
@export var bg_music_player : AudioStreamPlayer
##The name of the map (or its key in a csv translation file).
@export var map_name : String = "Placeholder"
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
	for entity in entities.get_children():
		entity.original_map_id = id


func _on_chunk_entered(body : Node2D, chunk : Chunk) -> void:
	if body is Player:
		owner.current_chunk = chunk
		if owner.current_map != self:
			print("changing map ", self, " pos ", position, " global pos ", global_position)
			if owner.current_map != null and owner.current_map.bg_music_player != null:
				owner.current_map.bg_music_player.stop()
			owner.current_map = self
			if bg_music_player != null:
				bg_music_player.play()
			ScenesManager.add_map_scene_neighbours(id, global_position)
		Maplinker.refresh_chunks(chunk)
		Maplinker.force_chunk_activation(chunks)
	elif body is Entity:
		Maplinker.register_entity_in_chunk(chunk, body)
		if !chunk.need_to_process and (owner.current_map == null or body.original_map_id != owner.current_map.id):
			body.set_process_mode(4)


#func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	#GlobalVar.reserved_tiles.clear()
