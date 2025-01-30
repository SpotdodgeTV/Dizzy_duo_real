extends "res://enemy.gd"

signal next_phase

var phase_change_threshold = 300

func _ready():
	enemy_setup()
	health = 400

func damaged(damage):
	if active:
		play_animation("hurt", true)
		health -= damage
		boss_bar.value = health
		print("enemy received ", damage, " damage")
		if health <= 0 and !dead:
			dead = true
			play_animation("death", true)
			return
		if health < phase_change_threshold:
			phase_change_threshold -= 100
			emit_signal("next_phase")
