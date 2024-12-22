extends MenuBase


@onready var difficulty_button: TextureButton = $CanvasLayer/Background/VBoxContainer/DifficultyButton
@onready var phone_button: TextureSubMenuButton = $CanvasLayer/Background/VBoxContainer/PhoneButton

##The names of the OS found on mobile devices, used to know if the button to access the phone settings 
##should be visible.
var phone_os : Array[String] = ["Android", "iOS"]


func _ready() -> void:
	super()
	if GlobalVar.in_game:
		difficulty_button.show()
	else:
		difficulty_button.hide()

	if OS.get_name() in phone_os:
		phone_button.show()
