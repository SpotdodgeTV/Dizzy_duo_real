extends CharacterBody2D
@export var speed = 100
@export var damage = 10
var spawnPos : Vector2
var dir : float
var is_set =false
var reflected: bool = false 
@export var projectile_index: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	#global_position = spawnPos
	#rotation = dir
	pass
	

func set_params():
	position = spawnPos
	global_rotation = dir
	is_set = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#if not is_set:
		#set_params()
	velocity = Vector2(0, -speed).rotated(global_rotation)
	move_and_slide()
	#if Input.is_action_just_pressed("mouse_left"):
		#var mouse_pos = get_viewport().get_mouse_position() - get_viewport_rect().get_center()
		#var vector_to_mouse = position - mouse_pos
		#reflect(mouse_pos)
		##damaged(10)


func _on_area_2d_body_entered(body: Node2D):
	#print("HIT!")
	if body.is_in_group("player") && reflected == false:
		if body.is_in_group("cowboy"):
			body.parent.hurt(body, damage)
		elif body.is_in_group("knight"):
			if body.player_one.player_two_connected:
				body.player_one.current_speed *= 0.86
			else:
				body.sling((body.global_position - global_position), 0.04, body.global_position, false)
		queue_free()
	elif body.is_in_group("enemy") && reflected == true:
		body.damaged(damage)
		queue_free()
	elif body.is_in_group("object"):
		queue_free()

func reflect(target_pos : Vector2): 
	if !visible:
		return
	if(reflected):
		return
	print("target pos: ", target_pos)
	var angle_to_target = (target_pos - global_position).angle()
	global_rotation_degrees = rad_to_deg(angle_to_target) + 90
	$AnimatedSprite2D.animation = "reflected"
	speed += 50
	damage = 2
	reflected = true
	#velocity = Vector2(0, -speed).rotated(global_rotation + deg_to_rad(180))
	

func _on_life_timeout():
	#print("hi")
	queue_free()

func start_timer():
	#print("hello")
	$Life.start()
