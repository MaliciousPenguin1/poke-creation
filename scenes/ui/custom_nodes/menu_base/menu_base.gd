@tool
extends Control
class_name MenuBase


@export var first_button : Control


var parent_menu : MenuBase
var child_menu : MenuBase
var last_active_button


func _ready() -> void:
	await opening_animation()
	grab_first_button_focus()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		#If the only menu left is the main one. 
		if not child_menu:
			close()


func close() -> void:
	await closing_animation()
	if parent_menu:
		if parent_menu.last_active_button != null:
			parent_menu.last_active_button.grab_focus()
		else:
			parent_menu.grab_first_button_focus()
	queue_free()


func grab_first_button_focus() -> void:
	if first_button:
		first_button.grab_focus()


#A function in which you can write code to make a custom opening animation for your menu.
func opening_animation() -> void:
	pass


#A function in which you can write code to make a custom closing animation for your menu.
func closing_animation() -> void:
	pass
