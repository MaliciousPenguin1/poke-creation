extends MenuBase
class_name OptionsSubMenu


@onready var section_name_label: Label = $CanvasLayer/HBoxContainer/SideScrollTexture/MarginContainer/VBoxContainer/SectionNameLabel
@onready var section_description_label: Label = $CanvasLayer/HBoxContainer/SideScrollTexture/MarginContainer/VBoxContainer/SectionDescriptionLabel
@onready var screen_size_options_container: ScreenSizeOptionsContainer = $CanvasLayer/HBoxContainer/MarginContainer/ScrollContainer/VBoxContainer/ScreenSizeContainer/ScreenSizeOptionsContainer


#Auto-selects this option as it is the first one in the list.
func _ready() -> void:
	screen_size_options_container.selected = true
