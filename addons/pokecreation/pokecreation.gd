@tool
extends EditorPlugin


const TAB : PackedScene = preload("res://addons/pokecreation/tabs/main.tscn")

var main_tab_instance : Control


func _enter_tree() -> void:
	main_tab_instance = TAB.instantiate()
	get_editor_interface().get_editor_main_screen().add_child(main_tab_instance)
	_make_visible(false)


func _exit_tree() -> void:
	if main_tab_instance:
		main_tab_instance.queue_free()


func _make_visible(visible: bool) -> void:
	if main_tab_instance:
		main_tab_instance.visible = visible


func _has_main_screen() -> bool:
	return true


func _get_plugin_name() -> String:
	return "PokéCreation"


func _get_plugin_icon() -> Texture2D:
	return load("res://addons/pokecreation/icon.svg")
