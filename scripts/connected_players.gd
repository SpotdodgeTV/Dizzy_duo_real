extends Node2D

var health: int = 100
var dead: bool = false

func hurt(damage = 10):
	health -= damage
	
	if health <= 0:
		dead = true
