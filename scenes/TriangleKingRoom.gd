extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AmbientMusic.fade_out()
	$main_boss/Main_body.connect("has_died", boss_done)
	$SceneChanger.change_shader_pos(Vector2(1.2, 0.5))
	await $BossIntro.finished
	$MusicPlayer.play()

func boss_done():
	$Arrow.arrow_time()
	$Door.door_enabled = true
	$MusicPlayer/AnimationPlayer.play("fade_out")
	await $MusicPlayer/AnimationPlayer.animation_finished
	AmbientMusic.play_loop()
