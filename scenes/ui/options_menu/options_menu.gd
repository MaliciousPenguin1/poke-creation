extends MenuBase


@onready var difficulty_button: TextureButton = $CanvasLayer/Background/VBoxContainer/DifficultyButton


func _ready() -> void:
	if GlobalVar.in_game:
		difficulty_button.show()
