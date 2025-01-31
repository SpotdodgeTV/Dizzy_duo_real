extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Dialog.play("tutorial")

func dialog_signal(dialog_name, key):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
