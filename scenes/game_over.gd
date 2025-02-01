extends CanvasLayer

@onready var scene_changer = get_tree().get_nodes_in_group("SceneChanger")[0]

func _on_play_pressed() -> void:
	scene_changer.change_scene(get_tree().current_scene.scene_file_path)

func play_splat():
	$AnimatedSprite2D.play("splat")
