extends CharacterBody2D

@onready var main = self.get_parent()
#@onready var projectile = load("res://scenes/Attack_patterns/projectile.tscn")
# Called when the node enters the scene tree for the first time.
var health: int = 100
@onready var attacks = {
	0: load("res://scenes/Attack_patterns/basic_attack.tscn"),
	1: load("res://scenes/Attack_patterns/burst.tscn"),
	2: load("res://scenes/Attack_patterns/inverting_arc.tscn"),
	3: load("res://scenes/Attack_patterns/cross_burst.tscn")
}

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var mouse_pos = get_viewport().get_mouse_position()
	var vector_to_mouse = get_viewport_rect().get_center() - mouse_pos
	rotation = vector_to_mouse.angle() - PI/2
	$face.global_rotation = 0
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
	var instance = attack.instantiate()
	instance.rotation = rotation
	instance.position = global_position
	instance.speed = 100
	main.add_child.call_deferred(instance)

func _on_cooldown_timeout():
	#pass
	var random_attack = randi() % attacks.size()
	shoot_attack(attacks[random_attack])
	



func damaged(damage):
	health -= damage
	print("enemy received ", damage, " damage")
	if health <= 0 :
		queue_free()
