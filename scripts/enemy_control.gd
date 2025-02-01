extends Node2D

signal enemy_dead
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Enemy.connect("has_died", _on_enemy_has_died)

func activate():
	$Enemy.active = true

func deactivate():
	$Enemy.active = false


func _on_enemy_has_died() -> void:
	emit_signal("enemy_dead")
