@tool
extends TextureSoundButton
class_name TextureSubMenuButton


@export var menu : PackedScene

@onready var parent_menu : MenuBase = owner


func _on_pressed() -> void:
	super()
	if menu == null or parent_menu == null:
		push_error("The \"", name, "\" button of the \"", owner.name, "\" scene doesn't seem to have a menu or a parent menu associated with it.")
		return
	
	var new_menu : MenuBase = menu.instantiate()
	new_menu.parent_menu = parent_menu
	
	parent_menu.add_child(new_menu)
	parent_menu.child_menu = new_menu
	parent_menu.last_active_button = self
