extends Resource
class_name LevelUpMove


##Used in the Species resource to define at which level a Pokémon is meant to learn a move.


##The move to learn.
@export var move : Move
##The level at whoch the move is meant to be learned.
@export_range(1, GlobalConstants.MAX_LEVEL) var level : int = 1
