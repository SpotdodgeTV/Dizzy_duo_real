extends Area2D

@onready var scene_changer = $"../SceneChanger"
@export var scene_file: String = ""
@export var shader_pos: Vector2 = Vector2(0.5,0.5)
var door_enabled: bool = false

func _ready() -> void:
	connect("body_entered", door_touched)

func door_touched(body):
	if body.is_in_group("cowboy") and door_enabled:
		scene_changer.change_shader_pos(shader_pos)
		scene_changer.change_scene(scene_file)
