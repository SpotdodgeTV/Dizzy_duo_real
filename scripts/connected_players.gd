extends Node2D

var health: int = 10
var dead: bool = false
var hearts_list : Array[TextureRect]
@onready var player_healthbar = $"../CanvasLayer/PlayerHealth"
@onready var player_one = $Player1
@onready var player_two = $Player2
@onready var game_over_screen = preload("res://scenes/game_over.tscn")


func _ready() -> void:
	pass

func hurt(body, damage = 10):
	if !body.animation_player.is_playing():
		health -= 1
		player_healthbar.update_hearts(health)
		$AudioStreamPlayer2D.play()
		if health <= 0 and !dead:
			dead = true
			add_child(game_over_screen.instantiate())
		body.animation_player.play("hurt")
