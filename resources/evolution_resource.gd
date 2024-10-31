extends Resource
class_name EvolutionData


##A resource used to define the conditions recquired for certain species to evolve into other species.


##The species to be evolved into.
@export var evolution : Species
##The minimum level that needs to be reached for the evolution to happen.
@export_range(2,GlobalConstants.MAX_LEVEL) var level : int = 2
##The item that needs to be held.
@export var held_item : Item
##The item that needs to be used.
@export var used_item : Item
##The amount of a certain item that need to be in the bag for the Pokémon to evolve (currently only 
##used for the Gimmighoul->Gholdengo evolution).
@export var items_in_bag : ItemQuantity
##The move that needs to be known.
@export var move_known : Move
##Wether the Pokémon needs to be friend with you.
@export var friendship : bool = false
##The map in which you need to be for the evolution to happen.
@export var map : Map
##The timeframe the evolution can happen.[br]
##x is the time after which it can happen and y is the time before which it can happen.[br]
##For example, a Pokémon that can only evolve between 8 pm (20h) and 4 am (4h) will have this value 
##set to x=20 and y=4.
@export var time : Vector2i = Vector2i.ZERO
##The gender the Pokémon needs to be in order to evolve.
@export_enum("Any", "Male", "Female") var gender : String = "Any"
##The name of a potential other condition that needs to be met.
@export var other_condition : String
