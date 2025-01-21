extends Node2D

@onready var main = get_tree().get_root().get_node("main")
@onready var projectile = load("res://scenes/Attack_patterns/projectile.tscn")
@onready var attack = load("res://scenes/Attack_patterns/basic_attack.tscn")
# Called when the node enters the scene tree for the first time.
var health: int = 100

func _ready():
	#rotation_degrees = 90
	#shoot_burst()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var mouse_pos = get_viewport().get_mouse_position()
	var vector_to_mouse = get_viewport_rect().get_center() - mouse_pos
	rotation = vector_to_mouse.angle() - PI/2
	if Input.is_action_just_pressed("mouse_left"):
		damaged(10)
	if health <= 0 :
		queue_free()
	#print(rotation)

func shoot():
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	instance.speed = 200
	main.add_child.call_deferred(instance)

func shoot_burst():
	var temp = -15 * PI/180
	for n in 3:
		var instance = projectile.instantiate()
		instance.dir = rotation + temp
		instance.spawnPos = global_position
		instance.speed = 200
		main.add_child.call_deferred(instance)
		temp += 15 * PI/180

func shoot_attack():
	var instance = attack.instantiate()
	instance.rotation = rotation
	instance.position = global_position
	instance.speed = 100
	main.add_child.call_deferred(instance)

func _on_cooldown_timeout():
	#pass
	var random_attack = randi_range(0, 2)
	if random_attack == 0:
		shoot_attack()
	elif random_attack == 1:
		shoot()
	else:
		shoot_burst()


func damaged(damage):
	health -= damage
	print("enemy received ", damage, " damage")
