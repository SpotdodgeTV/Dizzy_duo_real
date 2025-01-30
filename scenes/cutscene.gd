extends Control

func _ready() -> void:
	$Dialog.connect("finished", next_scene)

func dialog_signal(dialog_name, key):
	match key:
		2:
			$AnimationPlayer.play("portal_fade_in")
		3:
			$AnimationPlayer.play("fly")

func next_scene():
	$SceneChanger.change_scene("res://scenes/cutscene2.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
