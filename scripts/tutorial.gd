extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AmbientMusic.play_loop()
	$Dialog.connect("finished", unlock_door)
	$Players/Player1.can_move = false
	$Dialog.play("tutorial", 6, true)

func dialog_signal(dialog_name, key):
	match key:
		6:
			$Players/Player1.can_move = true

func unlock_door():
	$Door.door_enabled = true
