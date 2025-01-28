extends "res://enemy.gd"

func damaged(damage):
	if active:
		play_animation("hurt", true)
		health -= damage
		boss_bar.value = health
		print("enemy received ", damage, " damage")
		if health <= 0 and !dead:
			dead = true
			play_animation("death", true)
	
