extends Resource
class_name Species


##Data about the various species of Pokémon. Shouldn't be confused with the Pokémon resources, 
##which define data about singular members of a specific species (Like nickname, current level, 
##current moves, ...).


##General informations about your Pokémon species.
@export_group("General")
##Each Pokémon species needs to have a unique ID to differentiate Pokémon from the same species 
##but with different forms, like regional variants for example.
@export var id : String = "PLACEHOLDER"
##The name displayed on the screen.
@export var name : String = "PLACEHOLDER"
##The name of the species current form (Exemple: Mega, Alolan, Plant Cloak, ...).[br]
##Leave empty for Pokémon without alternative forms.
@export var form_name : String
##Define wether the Pokémon species is an Ultra-Beast or not (and by extension, the catch rate a 
##Beast ball has on it).
@export var is_ultra_beast : bool = false
##Define the species lineage:
@export var lineage : Species
##Tells wether the Pokémon from this species are still in their juvenile state.
@export var juvenile : bool = false

@export_group("Types")
##Mandatory. You [color=red]have[/color] to attribute a type here. 
##To do so, drag and drop a type from [kbd]res://resources/types/[/kbd]
@export var type1 : Type
##Optional secondary type.
@export var type2 : Type
##A list of all of the secondary affinities of this Pokémon.
@export var secondary_affinities : Array[Type]

@export_group("Growth")
##A number used in the calculation of the experience gained after defeating a Pokémon from that species.[br]
##To learn more about it, go to [url]https://bulbapedia.bulbagarden.net/wiki/Experience[/url][br]
##To see the base experience yield of regular Pokémon, go to [url]https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_effort_value_yield[/url]
@export_range(1,999) var base_exp_yield : int = 36
##The groups used to define how fast a Pokémon from that species level-up.[br]
##To learn more about it, go to [url]https://bulbapedia.bulbagarden.net/wiki/Experience#Relation_to_level[/url]
@export_enum("Erratic","Fast","Medium Fast","Medium Slow","Slow","Fluctuating") var experience_group : String = "Medium Fast"
##The catch rate is a number indicating how easy or hard a Pokémon from that species is to catch.[br]
##The higher this number is, the easier it will be to catch a Pokémon from that species.[br]
##To learn more about it, go to [url]https://bulbapedia.bulbagarden.net/wiki/Catch_rate[/url][br]
##To see the catch rate of regular Pokémon, go to [url]https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_catch_rate[/url]
@export_range(1,255) var catch_rate : int = 255
##The value of the "friendship" attribute of a Pokémon from that species when it's caught.[br]
##To learn more about it, go to [url]https://bulbapedia.bulbagarden.net/wiki/Friendship[/url][br]
##To see the base friendship of regular Pokémon, go to [url]https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_base_friendship[/url]
@export_range(0,255) var base_friendship : int = 50

@export_group("Abilities")
##Mandatory. You [color=red]have[/color] to attribute an ability here.[br]
##To do so, drag and drop a type from [kbd]res://resources/abilities[/kbd]
@export var ability_1 : Ability
##Optional secondary ability.
@export var ability_2 : Ability
##Optional ability that can't be found on regular wild Pokémon from that species.[br]
##To learn more about it, go to [url]https://bulbapedia.bulbagarden.net/wiki/Ability#Hidden_Abilitiesalues[/url]
@export var hidden_ability : Ability

@export_group("Gender and Egg")
##This value represent the probability of encountering a male Pokémon from this species.[br]
##A value of 100 will make it so that you can only meet male Pokémon of this species, and a value of 0 will make it so that those Pokémon can only be met as females.
##To see the gender ratio of regular Pokémon, go to [url]https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_gender_ratio[/url]
@export_range(0,100, 12.5) var gender_ratio : int = 50
##Defines if Pokémon from that species are genderless or not.[br]
##If this value is set to true, the value of the "gender_ratio" variable doesn't matter.
@export var is_genderless : bool = false
##If the Pokémon can breed or not. Always false when is_genderless = false.
@export var can_breed : bool = true
##The categories used to determine the "breeding capabilities" of Pokémon from that species.[br]
##To learn more about it, go to [url]https://bulbapedia.bulbagarden.net/wiki/Egg_Group[/url][br]
##To see the egg groups of regular Pokémon, go to [url]https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_base_Egg_cycles[/url][br]
##Mandatory. You [color=red]have[/color] to attribute an egg group here.
@export_enum("Monster","Water1","Bug","Flying","Field","Fairy","Grass","Human-Like","Water3","Mineral","Amorphous","Water2","Ditto","Dragon","NoEggsDiscovered") var egg_group1 : String = "NoEggsDiscovered"
##Optional secondary egg group.
@export_enum("None","Monster","Water1","Bug","Flying","Field","Fairy","Grass","Human-Like","Water3","Mineral","Amorphous","Water2","Ditto","Dragon","NoEggsDiscovered") var egg_group2 : String = "None"
##The number of steps needed to complete a cycle.[br]
##To learn more about it, go to [url]https://bulbapedia.bulbagarden.net/wiki/Egg_cycle[/url]
@export_range(1,999999) var hatch_steps : int = 5120
##The number of cycles needed for an egg to hatch.[br]
##To learn more about it, go to [url]https://bulbapedia.bulbagarden.net/wiki/Egg_cycle[/url]
@export_range(1,200) var egg_cycles : int = 20
##The Pokémon's evolution(s).[br]
@export var evolutions : Array[EvolutionData]


@export_group("Pokédex")
##The number assigned to this Pokémon species in the Pokédex.[br]
##Leaving this value empty will prevent the Pokémon from appearing in the Pokedex.[br]
##You can give the same number to the different forms of a Pokémon to makes their infos appear on the same page.
@export var regional_pokedex_number : int
@export var national_pokedex_number : int
##The height of Pokémon from this species in meters. Will automatically be converted to the 
##United States customary units for the people using them.
@export_range(0,9999999, 0.01) var height : float = 1.0
##The weight of a Pokémon from this species in kilograms. Will automatically be converted in
##pounds for the people using them.
@export_range(0,9999999, 0.01) var weight : float = 1.0
##The color used in the Pokédex's searching algorithm.
@export_enum("Red", "Blue", "Yellow", "Green", "Black", "Brown", "Purple", "Gray", "White", "Pink") var color : String = "Red"
##The shape used in the Pokédex's searching algorithm.[br]
##To see the different body shapes available, go to [url]https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_shape[/url]
@export_enum("Only Head", "Head and Legs", "Fins", "Insectoid", "Quadruped","2+ Pairs of wings", "Multiple bodies", "Tentacles", "Head and base", "Bipedal with tail", "Bipedal without tail", "1 pair of wings", "Serpentine", "Head and arms") var shape : String = "Only Head"
##A name which identifies the Pokémon species based on one of its defining biological characteristics.[br]
##To see a list of regular Pokémon's categories, go to [url]https://bulbapedia.bulbagarden.net/wiki/Pok%C3%A9mon_category[/url]
@export var category : String
##The Pokémon species Pokédex decription.[br]
##Can be formatted using BBCode ([url]https://docs.godotengine.org/en/latest/tutorials/ui/bbcode_in_richtextlabel.html#reference[/url])
@export_multiline var pokedex_entry : String

@export_group("Stats")
##To learn more about base stats in general, go to [url]https://bulbapedia.bulbagarden.net/wiki/Base_stats[/url][br]
##To see the base stats of regular Pokémon, go to [url]https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_base_stats_(Generation_IX)[/url]
@export_range(1,255) var base_hp : int = 40
@export_range(1,255) var base_attack : int = 40
@export_range(1,255) var base_defense : int = 40
@export_range(1,255) var base_special_attack : int = 40
@export_range(1,255) var base_special_defense : int = 40
@export_range(1,255) var base_speed : int = 40
##The amount of EVs gained after defeating Pokémon from this species.[br]
##The total of all of these values is between 0 and 3.
##To learn more about it, go to [url]https://bulbapedia.bulbagarden.net/wiki/Effort_values[/url]
##To see the effort value yield of regular Pokémon, go to [url]https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_effort_value_yield[/url]
@export_range(0,3) var ev_hp : int = 0
@export_range(0,3) var ev_attack : int = 0
@export_range(0,3) var ev_defense : int = 0
@export_range(0,3) var ev_special_attack : int = 0
@export_range(0,3) var ev_special_defense : int = 0
@export_range(0,3) var ev_speed : int = 0

@export_group("Movesets")
## Mandatory. You [color=red]have[/color] to add at least a LevelUpMove here.[br]
@export var level_up_moves : Array[LevelUpMove]
##Moves learned once the previous form of a Pokémon from this species has evolved into this one.
##To add a move here, click on the "Array[Move](size 0)" button,
## click on "Add Element" and drag and drop a move from [kbd]res://resources/moves[/kbd].[br]
## If you want to add more moves, simply click on "Add Element" again, drag and drop
## another move and repeat the process as many times as necessary.
@export var evolution_moves : Array[Move]
@export var tutor_moves : Array[Move]
@export var egg_moves : Array[Move]

@export var shadow_moves : Array[Move]
@export var light_moves : Array[Move]
