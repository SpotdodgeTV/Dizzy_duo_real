extends Node2D

var health: int = 10
var dead: bool = false
var hearts_list : Array[TextureRect]
@export var change_pos_for_vertical: bool = false
@onready var player_healthbar = $"../CanvasLayer/PlayerHealth"
@onready var player_one = $Player1
@onready var player_two = $Player2
@onready var game_over_screen = preload("res://scenes/game_over.tscn")


func _ready() -> void:
	if change_pos_for_vertical:
		player_one.position = Vector2(0,25)
		player_two.position = Vector2(0,-25)

func hurt(body, damage = 10):
	if !body.animation_player.is_playing():
		health -= 1
		player_healthbar.update_hearts(health)
		$AudioStreamPlayer2D.play()
		if health <= 0 and !dead:
			game_over()
		body.animation_player.play("hurt")

func game_over():
	dead = true
	player_one.can_move = false
	player_two.can_attack = false
	add_child(game_over_screen.instantiate())
	
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.active = false
