extends Node2D

var health: int = 10
var dead: bool = false
var hearts_list : Array[TextureRect]

func _ready() -> void:
	pass

func hurt(body, damage = 10):
	health -= 1
	$PlayerHealth2.update_hearts(health)
	
	if health <= 0:
		dead = true
	
	body.animation_player.play("hurt")
