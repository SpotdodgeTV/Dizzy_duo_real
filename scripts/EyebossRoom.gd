extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SceneChanger.change_shader_pos(Vector2(1.2, 0.5))
	$main_boss/Main_body.connect("has_died", unlock_door)
	AmbientMusic.fade_out()
	await $BossIntro.finished
	$MusicPlayer.play()

func unlock_door():
	$Door.door_enabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
