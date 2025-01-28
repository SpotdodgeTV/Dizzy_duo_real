extends CharacterBody2D

@onready var main = self.get_parent()
@onready var players = get_tree().get_nodes_in_group("player")
@onready var closest_player = players[1]
@onready var animation_player = $face/AnimationPlayer
@onready var health_bar = $"../ProgressBar"
@onready var boss_bar = $"../../CanvasLayer/BossHealth"
@export var active:bool = true
@export var enemy_name = "boss1"
var dead:bool = false
#@onready var projectile = load("res://scenes/Attack_patterns/projectile.tscn")
# Called when the node enters the scene tree for the first time.
var health: int = 100
@onready var attacks = {
	0: load("res://scenes/Attack_patterns/basic_attack.tscn"),
	1: load("res://scenes/Attack_patterns/burst.tscn")
	#2: load("res://scenes/Attack_patterns/inverting_arc.tscn"),
	#3: load("res://scenes/Attack_patterns/cross_burst.tscn"),
	#4: load("res://scenes/Attack_patterns/machinegun.tscn"),
	#5: load("res://scenes/Attack_patterns/machine_arc.tscn"),
	#6: load("res://scenes/Attack_patterns/eight_way_burst.tscn")
}

func _ready():
	enemy_setup()
	#global_rotation = closest_player.global_position.angle()

func enemy_setup():
	match enemy_name:
		"boss1":
			$face.animation = "spit"
		"triangleboss":
			$face.animation = "triangleboss"

func get_closest_player():
	for player in players:
		if global_position.distance_to(player.global_position) < global_position.distance_to(closest_player.global_position):
			closest_player = player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if active:
		if Engine.get_process_frames() % 30 == 0:
			get_closest_player()
		global_rotation = lerp_angle(global_rotation, global_position.angle_to_point(closest_player.global_position) + 1.57, 5 * delta)
	#var mouse_pos = get_viewport().get_mouse_position()
	#var vector_to_mouse = get_viewport_rect().get_center() - mouse_pos
	#print(get_angle_to(closest_player.global_position))#get_angle_to(closest_player.global_position), closest_player.name)
	#vector_to_mouse.angle() - PI/2wd
	#$face.global_rotation = 0
	#if Input.is_action_just_pressed("mouse_left"):
		#damaged(10)


#func shoot():
	#var instance = projectile.instantiate()
	#instance.dir = rotation
	#instance.spawnPos = global_position
	#instance.speed = 200
	#main.add_child.call_deferred(instance)
#
#func shoot_burst():
	#var temp = -15 * PI/180
	#for n in 3:
		#var instance = projectile.instantiate()
		#instance.dir = rotation + temp
		#instance.spawnPos = global_position
		#instance.speed = 200
		#main.add_child.call_deferred(instance)
		#temp += 15 * PI/180

func shoot_attack(attack):
	
	if enemy_name == "boss1":
		play_animation("spit", false)
	elif enemy_name == "triangleboss":
		play_animation("triangle_attack", false)
	var instance = attack.instantiate()
	#instance.zdex = -1
	
	instance.rotation = rotation
	instance.position = position
	instance.speed = 0
	main.add_child.call_deferred(instance)

func _on_cooldown_timeout():
	if !dead && active:
		var random_attack = randi() % attacks.size()
		shoot_attack(attacks[random_attack])

func play_animation(anim: String = "", force:bool = false):
	if !animation_player.is_playing() or force:
		animation_player.play(anim)



func damaged(damage):
	if active:
		play_animation("hurt", true)
		health -= damage
		if !main.is_in_group("sub-boss"):
			boss_bar.value = health
		print("enemy received ", damage, " damage")
		if health <= 0 and !dead:
			if main.is_in_group("sub-boss"):
				active = false
				return
			dead = true
			play_animation("death", true)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		queue_free()
