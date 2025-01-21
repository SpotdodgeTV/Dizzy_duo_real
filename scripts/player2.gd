extends RigidBody2D

@onready var parent = $"../"
@onready var device_num: int = Global.player_two_device_num

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
			if Input.is_action_just_pressed("mouse_left"):
				sword_animation.play("Swing")
		_: #controller
			if Input.get_joy_axis(device_num, JOY_AXIS_TRIGGER_RIGHT) > 0.1:
				sword_animation.play("Swing")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sword.rotation = get_sword_angle()
	#sword.rotation = lerp_angle(sword.rotation, get_angle_to(get_local_mouse_position()), SWORD_ROTATION_SPEED * delta)

func sling(direction, speed, nposition):
	global_position = nposition
	apply_impulse(direction * (speed * MAGNITUDE), nposition)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.damaged(20)
