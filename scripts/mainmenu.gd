extends Control

func _on_play_pressed() -> void:
	$Button_pressed.play()
	$SceneChanger.change_scene("res://scenes/cutscene.tscn")

func _on_quit_pressed() -> void:
	$Button_pressed.play()
	get_tree().quit()

func move_up():
	$MoveUp.play("moveup")
