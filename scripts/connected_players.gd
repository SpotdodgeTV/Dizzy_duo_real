extends Node2D

var health: int = 10
var dead: bool = false
var hearts_list : Array[TextureRect]
@onready var player_healthbar = $"../CanvasLayer/PlayerHealth"
@onready var player_one = $Player1
@onready var player_two = $Player2


func _ready() -> void:
	pass

func hurt(body, damage = 10):
	health -= 1
	player_healthbar.update_hearts(health)
	
	if health <= 0:
		dead = true
	
	body.animation_player.play("hurt")
