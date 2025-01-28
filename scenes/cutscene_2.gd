extends Control

func _ready() -> void:
	pass

func dialog_signal(dialog_name, key):
	match key:
		2:
			$AnimationPlayer.play("portal_fade_in")
		3:
			$AnimationPlayer.play("fly")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
