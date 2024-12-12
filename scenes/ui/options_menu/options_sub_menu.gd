extends MenuBase
class_name OptionsSubMenu


@onready var section_name_label: Label = $CanvasLayer/HBoxContainer/SideScrollTexture/MarginContainer/VBoxContainer/SectionNameLabel
@onready var section_description_label: Label = $CanvasLayer/HBoxContainer/SideScrollTexture/MarginContainer/VBoxContainer/SectionDescriptionLabel
@onready var screen_size_options_container: ScreenSizeOptionsContainer = $CanvasLayer/HBoxContainer/MarginContainer/ScrollContainer/VBoxContainer/ScreenSizeContainer/ScreenSizeOptionsContainer


func _ready() -> void:
	screen_size_options_container.selected = true
