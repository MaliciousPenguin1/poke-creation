extends MarginContainer
class_name DialogBox


const TIME_MODIFIER_IN_DIALOG : float = 0.5
const DIALOG_SPEED : Dictionary = {
	Settings.TextSpeed.SLOW : 3,
	Settings.TextSpeed.NORMAL : 2,
	Settings.TextSpeed.FAST : 1,
	Settings.TextSpeed.INSTANT : 0
}


@onready var dialog_label: RichTextLabel = $MarginContainer/DialogLabel


var current_max_line : int = 1
var character_to_see : int = -1

var tween : Tween


func show_text(text : String) -> void:
	GlobalVar.time_speed = TIME_MODIFIER_IN_DIALOG
	GlobalVar.can_pause = false
	
	character_to_see = text.length() #TEMPORAIRE
	
	dialog_label.visible_characters = 0
	dialog_label.text = text
	
	#while dialog_label.get_character_line(character_to_see) <= current_max_line:
			#character_to_see += 1
			#print(dialog_label.get_character_line(character_to_see))
	
	_animate_dialog()


func _animate_dialog() -> void:
	tween = create_tween()
	tween.tween_property(dialog_label, "visible_characters", character_to_see, DIALOG_SPEED[Settings.text_speed]).from_current()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if dialog_label.visible_ratio >= 1:
			GlobalVar.time_speed = 1
			GlobalVar.can_pause = true
			queue_free()
		
		if dialog_label.visible_characters == character_to_see:
			#Scroll to next line
			current_max_line += 1
			#while dialog_label.get_character_line(character_to_see) <= current_max_line:
				#character_to_see += 1
		else:
			tween.kill()
			dialog_label.visible_characters = character_to_see
			_animate_dialog()
