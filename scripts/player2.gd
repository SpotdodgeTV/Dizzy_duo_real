extends RigidBody2D

@onready var parent = $"../"
@onready var player_one = $"../Player1"
@onready var device_num: int = Global.player_two_device_num

@onready var animation_player = $Sprite2D2/AnimationPlayer
@onready var sword = $Sword
@onready var sword_animation = $Sword/AnimationPlayer

const MAGNITUDE = 100
const SWORD_ROTATION_SPEED = 15
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
	
	match device_num:
		-1: #keyboard and mousea
			if Input.is_action_just_pressed("mouse_right"):
				sword_animation.play("Swing")
		_: #controller
			if Input.get_joy_axis(device_num, JOY_AXIS_TRIGGER_LEFT) > 0.1:
				sword_animation.play("Swing")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sword.rotation = get_sword_angle()
	#sword.rotation = lerp_angle(sword.rotation, get_angle_to(get_local_mouse_position()), SWORD_ROTATION_SPEED * delta)

func sling(direction : Vector2, speed, nposition, add_angle:bool = true):
	#global_position = nposition
	if add_angle:
		direction = direction.rotated(deg_to_rad(80))
	apply_impulse(direction * (speed * MAGNITUDE), nposition)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.damaged(20)
		if player_one.player_two_connected:
			player_one.end_lasso(1, (global_position - body.global_position).normalized())
		else:
			sling((global_position - body.global_position).normalized(), 2, global_position, false)

func _on_body_col_body_entered(body: Node2D) -> void:
	if body.is_in_group("object") or body.is_in_group("enemy"):
		
		if player_one.player_two_connected:
			player_one.end_lasso(-1)
		else:
			print("test")
			sling((player_one.global_position - global_position).normalized(), 1.5, global_position, false)
		
		
		#sling(linear_velocity.normalized(), -2, global_position)
		print("touched object")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		print("hello")
		
		area.get_parent().reflect(get_global_mouse_position())
