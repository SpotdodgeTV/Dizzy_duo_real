extends "res://scripts/enemy.gd"

signal next_phase

@export var phase_change_threshold = 300
@export var phase_change_increment = 100
@export var initial_health = 400
@export var has_laser:bool = false
var ray_caster
var laser 

func _ready():
	enemy_setup()
	health = initial_health
	if has_laser:
		ray_caster = $RayCast2D
		laser = $Laser
		laser.points[0] = Vector2(position.x + 18, position.y)
		laser.default_color = laser.INVIS
		ray_caster.add_exception(players[0])
		ray_caster.add_exception(players[1])

func damaged(damage):
	if active:
		$Damage_sound.play()
		play_animation("hurt", true)
		health -= damage
		boss_bar.value = health
		print("enemy received ", damage, " damage")
		if health <= 0 and !dead:
			emit_signal("has_died")
			dead = true
			play_animation("death", true)
			$AudioStreamPlayer2D.play()
			return
		if health <= phase_change_threshold:
			phase_change_threshold -= phase_change_increment
			emit_signal("next_phase")

func shoot_attack(attack):
	if enemy_name == "boss1":
		play_animation("spit", false)
	elif enemy_name == "triangleboss":
		play_animation("triangle_attack", false)
	var instance = attack.instantiate()
	if randi_range(3, 3) == 3 && has_laser:
		shoot_laser()
	instance.rotation = rotation
	instance.position = position
	#instance.speed = 0
	main.add_child.call_deferred(instance)
	
func shoot_laser():
	if laser.is_shooting:
		return
	laser.activate()

func _process(delta: float) -> void:
	super._process(delta)
	
	if has_laser:
		if laser.is_shooting:
			$RayCast2D.get_collider()
			var ray_point = ray_caster.get_collision_point()
			laser.points[1].x = global_position.distance_to(ray_point)
			laser.global_rotation_degrees = global_rotation_degrees - 90
