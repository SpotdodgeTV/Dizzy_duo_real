extends Node2D

@onready var boss_health = $CanvasLayer/BossHealth
@onready var trigger = $Trigger
var boss_started = false

func start_boss(body):
	if body.is_in_group("player") and !boss_started:
		boss_started = true
		AmbientMusic.fade_out()
		await AmbientMusic.animation_player.animation_finished
		var tween = create_tween()
		tween.tween_property(boss_health, "modulate:a", 1, 4)
		$BossStart.play("boss_start")
		await $BossStart.animation_finished
		$Boss.activate()
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Boss.deactivate()
	trigger.connect("body_entered", start_boss)
	$SceneChanger.change_shader_pos(Vector2(0.5, 0.9))
	$Boss.connect("enemy_dead", boss_over)

func boss_over():
	$Door.door_enabled = true
	$MusicPlayer/AnimationPlayer.play("fade_out")
	await $MusicPlayer/AnimationPlayer.animation_finished
	$BossWin.play()
	await $BossWin.finished
	AmbientMusic.play_loop()
