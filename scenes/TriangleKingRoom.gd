extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SceneChanger.change_shader_pos(Vector2(1.2, 0.5))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
