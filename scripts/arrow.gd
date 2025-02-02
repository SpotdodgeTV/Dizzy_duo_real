extends Marker2D

func _ready() -> void:
	$Arrow.modulate.a = 0

func arrow_time():
	$AnimationPlayer.play("wiggle")
	var tween = create_tween()
	tween.tween_property($Arrow, "modulate:a", 1, 1)
