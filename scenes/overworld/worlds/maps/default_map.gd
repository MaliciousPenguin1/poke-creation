extends Node2D
class_name Map


##Resource used to handle the various data if individual maps.


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
