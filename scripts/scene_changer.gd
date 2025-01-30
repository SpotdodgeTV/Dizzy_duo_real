extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = true

func change_scene(scene_name: String):
	$AnimationPlayer.play_backwards("circle_open")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(scene_name)
