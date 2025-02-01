extends CanvasLayer

func _on_play_pressed() -> void:
	$SceneChanger.change_scene(str(get_tree().current_scene))
