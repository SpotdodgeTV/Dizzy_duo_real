extends RigidBody2D

@onready var parent = $"../"
@onready var player_one = $"../Player1"
@onready var device_num: int = Global.player_two_device_num

@onready var animation_player = $Sprite2D2/AnimationPlayer
@onready var sword = $Sword
@onready var sword_animation = $Sword/AnimationPlayer

var can_attack: bool = true
const MAGNITUDE = 100
const SWORD_ROTATION_SPEED = 15
var is_slinging:bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func get_sword_angle():
	match device_num:
		-1: #keyboard and mouse
			return get_angle_to(get_global_mouse_position())
		_: #controller
			var right_stick_direction: Vector2 = Vector2(Input.get_joy_axis(device_num, 2), Input.get_joy_axis(device_num, 3))
			return right_stick_direction.angle()

func _input(event: InputEvent) -> void:
	if can_attack:
		match device_num:
			-1: #keyboard and mousea
				if Input.is_action_just_pressed("mouse_right"):
					sword_animation.play("Swing")
			_: #controller
				if Input.get_joy_axis(device_num, JOY_AXIS_TRIGGER_LEFT) > 0.1:
					sword_animation.play("Swing")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#Shit
	#print(linear_velocity.length())
	#linear_velocity = linear_velocity.limit_length(400)
	#Shit
	
	sword.rotation = get_sword_angle()
	
	#collision/bouncing stuff
	for body in $BodyCol.get_overlapping_bodies():
		if body.is_in_group("object") or body.is_in_group("enemy"):
			if (body.is_in_group("pillar") or body.is_in_group("enemy")) and !player_one.lasso_pulled_in:
				return
			elif player_one.player_two_connected:
				player_one.end_lasso(-1)

func sling(direction : Vector2, speed, nposition, add_angle:bool = true):
	if !is_slinging:
		is_slinging = true
		#global_position = nposition
		if add_angle:
			direction = direction.rotated(deg_to_rad(80))
		print("direction: ", direction.length())
		apply_central_impulse(direction.limit_length(400) * (speed * MAGNITUDE))
		await get_tree().create_timer(0.5).timeout
		is_slinging = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		#$AudioStreamPlayer2D.play()
		if player_one.player_two_connected:
			player_one.end_lasso(2, (global_position - body.global_position).normalized())
		else:
			sling((global_position - body.global_position).normalized(), 2.8, global_position, false)
		body.damaged(20)

func _on_body_col_body_entered(body: Node2D) -> void:
	pass
	#if body.is_in_group("object") or body.is_in_group("enemy"):
		#
		#if player_one.player_two_connected:
			#if body.is_in_group("pillar") and !player_one.lasso_pulled_in:
				#return
			#player_one.end_lasso(-1)
		#else:
			#if player_one.lasso_pulled_in:
				#sling((player_one.global_position - global_position).normalized(), 1.5, global_position, false)
		
		
		#sling(linear_velocity.normalized(), -2, global_position)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet") && !area.is_in_group("laser"):
		print("hello")
		
		area.get_parent().reflect(get_global_mouse_position())
