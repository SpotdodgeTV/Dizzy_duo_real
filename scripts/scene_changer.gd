extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = true

func change_scene(scene_name: String, circle_pos = Vector2(0.5,0.5)):
	change_shader_pos(circle_pos)
	$AnimationPlayer.play_backwards("circle_open")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(scene_name)

func change_shader_pos(pos:Vector2 = Vector2(0.5,0.5)):
	$Black.material.set_shader_parameter("pos", pos)
