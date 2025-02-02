extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AmbientMusic.fade_out()
	$Dialog.play("end_cutscene")
	$Dialog.connect("finished", done)

func dialog_signal(dialog_name, key):
	match key:
		2:
			$Saloon/AnimationPlayer.play("CowboyStuff")
		3:
			$Saloon/AnimationPlayer.play("fade_out")
			$Future/AnimationPlayer.play("KnightStuff")

func done():
	$SceneChanger.change_scene("res://scenes/Credits.tscn")
