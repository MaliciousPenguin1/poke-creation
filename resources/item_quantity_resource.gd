extends Resource
class_name ItemQuantity


##Defines an item and the quantity of said item.


@export var item : Item
@export_range(1, GlobalConstants.MAX_ITEM_QUANTITY) var quantity : int = 1
