extends Entity
class_name Player


enum Gender {MALE, FEMALE}


@onready var animated_sprite_male: AnimatedSprite2D = $AnimatedSpriteMale
@onready var animated_sprite_female: AnimatedSprite2D = $AnimatedSpriteFemale


static var gender : Gender
static var player_name : String
static var trainer_id : String


func set_sprite() -> void:
	if sprite != null:
		sprite.visible = false
		
	match gender:
		Gender.MALE:
			sprite = animated_sprite_male
		Gender.FEMALE:
			sprite = animated_sprite_female

	sprite.visible = true
	
	
func _ready() -> void:
	super()
	player_name = "Aranel"
	trainer_id = "%05d" % randi_range(0, GlobalConstants.MAX_TRAINER_ID)
	gender = Gender.MALE
	set_sprite()
	
	GlobalVar.player = self
