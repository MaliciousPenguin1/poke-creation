extends Entity
class_name Player


@onready var animated_sprite_male: AnimatedSprite2D = $AnimatedSpriteMale
@onready var animated_sprite_female: AnimatedSprite2D = $AnimatedSpriteFemale
@onready var bump_audio: AudioStreamPlayer = %BumpAudio


var gender : GlobalConstants.PlayerGender
var player_name : String
var trainer_id : String
var money : int


func set_sprite() -> void:
	if sprite != null:
		sprite.visible = false
		
	match gender:
		GlobalConstants.PlayerGender.MALE:
			sprite = animated_sprite_male
		GlobalConstants.PlayerGender.FEMALE:
			sprite = animated_sprite_female

	sprite.visible = true
	
	
func _ready() -> void:
	super()
	player_name = "Aranel"
	trainer_id = "%05d" % randi_range(0, GlobalConstants.MAX_TRAINER_ID)
	gender = GlobalConstants.PlayerGender.MALE
	money = 0
	set_sprite()
	
	GlobalVar.player = self


func play_colliding_sound() -> void:
	bump_audio.play()
