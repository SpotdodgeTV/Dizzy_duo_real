extends Control

func _on_play_pressed() -> void:
	$SceneChanger.change_scene("res://scenes/cutscene.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
