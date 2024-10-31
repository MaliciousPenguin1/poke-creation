extends Resource
class_name Type


##The data about Pokémon types.


##The name of your type.
@export var type_name : String = "PLACEHOLDER"
##The color associated with said type.
@export_color_no_alpha var color : Color

##The effect this type has when attacking another one. If a type doesn't appear in any of the 
##categories below, attacks from this type associated with this resource will be normally effective against it.
@export_group("Attacking Effectiveness")
@export var super_effective : Array[Type]
@export var not_very_effective : Array[Type]
@export var no_effect : Array[Type]
