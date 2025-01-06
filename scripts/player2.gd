extends RigidBody2D

@onready var device_num: int = Global.player_two_device_num

@onready var sword = $Sword
@onready var sword_animation = $Sword/AnimationPlayer

const MAGNITUDE = 100
const SWORD_ROTATION_SPEED = 15
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		sword_animation.play("Swing")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sword.rotation = get_angle_to(get_local_mouse_position())
	#sword.rotation = lerp_angle(sword.rotation, get_angle_to(get_local_mouse_position()), SWORD_ROTATION_SPEED * delta)

func sling(direction, speed, nposition):
	global_position = nposition
	apply_impulse(direction * (speed * MAGNITUDE), nposition)
