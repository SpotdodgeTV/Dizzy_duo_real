extends AudioStreamPlayer2D

@onready var animation_player = $AnimationPlayer

func play_loop():
	volume_db = 0
	play()

func fade_out():
	animation_player.play("fade_out")
