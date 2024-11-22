extends Node
class_name Pokemon


@export var db_key : String #DATABASE KEY

@export var given_name : int

@export var trainer_name : String
@export_range (1, GlobalConstants.MAX_LEVEL) var obtained_level : int
@export var obtained_map_id : int
@export var ball_id : int
@export var id_number : String


@export_range (1, GlobalConstants.MAX_LEVEL) var level : int
@export var exp : int
@export_range (1, GlobalConstants.MAX_HAPINESS) var hapiness : int
@export var is_shiny : bool
@export var gender : GlobalConstants.PokemonGender

@export var iv : Array[int]
@export var ev : Array[int]

# TODO
@export var ability : int
@export var held_item_id : int
@export var nature_id : String


func init(db_key : String, level : int = 5, data : Dictionary = {}) -> void:
	self.db_key = db_key
	given_name = data["given_name"] if data.has("given_name") else db_key[0].to_upper() + db_key.substr(1,-1)
	trainer_name = data["trainer_name"] if data.has("trainer_name") else GlobalVar.player.name
	obtained_level = level
	#obtained_map_id
	#ball_id
	id_number = "%05d" % randi_range(0, GlobalConstants.MAX_TRAINER_ID)
	self.level = level
	#exp
	hapiness = data["hapiness"] if data.has("hapiness") else 0
	is_shiny = data["is_shiny"] if data.has("is_shiny") else (randi_range(1, GlobalConstants.SHINY_RATE) == GlobalConstants.SHINY_RATE)
	gender = data["gender"] if data.has("gender") else initialize_default_gender()
	#iv
	ev = [0, 0, 0, 0, 0, 0]
	#ability
	#held_item_id
	nature_id = data["nature_id"] if data.has("nature_id") else randi_range(0, 24)


func initialize_default_gender() -> GlobalConstants.PokemonGender: #TODO
	return GlobalConstants.PokemonGender.MALE if randi_range(0, 1) == 0 else GlobalConstants.PokemonGender.FEMALE
