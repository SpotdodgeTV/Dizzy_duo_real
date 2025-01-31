extends "res://enemy.gd"

signal next_phase

@export var phase_change_threshold = 300
@export var phase_change_increment = 100
@export var initial_health = 400


func _ready():
	enemy_setup()
	health = initial_health

func damaged(damage):
	if active:
		play_animation("hurt", true)
		health -= damage
		boss_bar.value = health
		print("enemy received ", damage, " damage")
		if health <= 0 and !dead:
			emit_signal("has_died")
			dead = true
			play_animation("death", true)
			return
		if health < phase_change_threshold:
			phase_change_threshold -= phase_change_increment
			emit_signal("next_phase")
