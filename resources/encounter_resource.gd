extends Resource
class_name Encounters


##Resource used to define the Pokémon species that can be encountered on a map.


## The species of the Pokémon to encounter
@export var species : String
## The "weight" of the Pokémon, ie: the odds of ot appearing.\br
## The higher this number is, the more likely your Pokémon is to appear.\br
## This value [color = red]has[/color] to be positive.
@export_range(1,100000000) var weight : int = 1
## The minimum level at which this Pokémon can be encountered.
@export_range(1,GlobalConstants.MAX_LEVEL) var minimum_level : int = 1
## The maximum level at which this Pokémon can be encountered.\br
## Needs to be higher or equal to the minimum level.
@export_range(1,GlobalConstants.MAX_LEVEL) var maximum_level : int = 1
