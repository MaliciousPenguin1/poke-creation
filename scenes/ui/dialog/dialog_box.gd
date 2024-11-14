extends MarginContainer
class_name DialogBox


@onready var dialog_label: RichTextLabel = $MarginContainer/DialogLabel


func show_text(text : String) -> void:
	dialog_label.visible_characters = 0
	var new_text : String = GlobalVar.text_parser.translate_and_parse_text(text)
	
	
