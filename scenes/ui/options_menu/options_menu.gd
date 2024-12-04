extends MenuBase


@onready var difficulty_button: TextureButton = $CanvasLayer/Background/VBoxContainer/DifficultyButton
@onready var phone_button: TextureSubMenuButton = $CanvasLayer/Background/VBoxContainer/PhoneButton


var phone_os : Array[String] = ["Android", "iOS"]


func _ready() -> void:
	super()
	if GlobalVar.in_game:
		difficulty_button.show()
	else:
		difficulty_button.hide()

	if OS.get_name() in phone_os:
		phone_button.show()
