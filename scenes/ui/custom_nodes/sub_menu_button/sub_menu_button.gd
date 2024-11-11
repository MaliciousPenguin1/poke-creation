@tool
extends SoundButton
class_name SubMenuButton


@export var menu : PackedScene

@onready var parent_menu : MenuBase = owner


func _on_pressed() -> void:
	if menu == null or parent_menu == null:
		push_error("The \"", name, "\" button of the \"", owner.name, "\" scene doesn't seem to have a menu or a parent menu associated with it.")
		return
	
	var new_menu : MenuBase = menu.instantiate()
	new_menu.parent_menu = parent_menu
	
	parent_menu.add_child(new_menu)
	parent_menu.child_menu = new_menu
