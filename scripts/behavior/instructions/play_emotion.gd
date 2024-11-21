extends Instruction
class_name InstructionPlayEmotion


enum EMOTIONS {EXCLAMATION, INTERROGATION}


@export var emotion : EMOTIONS


const EMOTIONS_TO_ANIMATION_NAME : Dictionary = {
	EMOTIONS.EXCLAMATION : "exclamation",
	EMOTIONS.INTERROGATION : "interrogation"
}


func consume(_object_to_instruct) -> void:
	var emotion_scene : Node2D = load("res://scenes/overworld/animations/emotions.tscn").instantiate()
	_object_to_instruct.add_child(emotion_scene)
	emotion_scene.play_emotion(EMOTIONS_TO_ANIMATION_NAME[emotion])
	await emotion_scene.tree_exited
	after_consumed_callback()
