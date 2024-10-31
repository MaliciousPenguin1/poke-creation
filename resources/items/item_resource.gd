extends Resource
class_name Item


##Data used to define things related to items.


##The name of the item.
@export var item_name : String = "PLACEHOLDER"
##The description of the item.
@export var item_description : String = "PLACEHOLDER"
##The pocket in which the item is meant to be placed.
@export_enum("Misc", "Battle", "Pokeballs", "Berries", "Medicine", "Key") var pocket : String = "Misc"
