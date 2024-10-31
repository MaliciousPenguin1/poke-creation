extends Resource
class_name Move


##The data relative to Pokémon moves.


@export var move_name : String = "PLACEHOLDER"
@export var move_description : String = "PLACEHOLDER"
##The amount of power points this move has.
@export_range(1,99) var power_points : int = 20
