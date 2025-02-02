extends CanvasLayer

var new_color = Color(2,0,0)
@onready var scene_changer = get_tree().get_nodes_in_group("SceneChanger")[0]
@onready var music_player = get_tree().get_nodes_in_group("MusicPlayer")[0]

func _ready() -> void:
	music_player.stop()

func _on_play_pressed() -> void:
	scene_changer.change_shader_pos(Vector2(0.5,0.5))
	scene_changer.change_scene(get_tree().current_scene.scene_file_path)

func play_splat():
	$AnimatedSprite2D.play("splat")


func _on_quit_pressed() -> void:
	get_tree().quit()
