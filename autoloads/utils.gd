extends Node


const DIALOG_BOX : PackedScene = preload("res://scenes/ui/dialog/dialog_box.tscn")


func show_dialog(text : String) -> void:
	var dialog_box : DialogBox = DIALOG_BOX.instantiate()
	ScenesManager.main.ui_parent.add_child(dialog_box)
	var new_text : String = TextParser.translate_and_parse_text(text)
	dialog_box.show_text(new_text)
	
