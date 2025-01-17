extends CharacterBody2D

@onready var device_num: int = Global.player_one_device_num

@onready var player1 = self
@onready var player2 = $"../Player2"
@onready var line = $"../Line2D"

var lasso_in_use = false
var player_two_connected = false

const STARTING_MOVEMENT_SPEED = 100
const MAX_MOVEMENT_SPEED = 150

var current_movement_speed: int = STARTING_MOVEMENT_SPEED
var radius: float = 100.0
var max_speed:float = 10.0
var deacceleration: float = 2.0
var current_speed: float = 0.0
var angle: float = 0.0
var input_sensitivity: float = 0.4
var target_position: Vector2 = Vector2.ZERO
var previous_angle_difference: float = 0.0

func get_movement_direction():
	match device_num:
		-1: #keyboard and mouse
			return Input.get_vector("keyboard_left", "keyboard_right", "keyboard_up", "keyboard_down")
		_: #controller
			return Vector2(Input.get_joy_axis(device_num, 0), Input.get_joy_axis(device_num, 1))

func spin_logic(all_criteria_met, target_angle, delta):
	if all_criteria_met:
		var angle_difference = angle_difference(angle, target_angle)
		if angle_difference > 0: #only clockwise motion
			previous_angle_difference = angle_difference
			angle = lerp_angle(angle, target_angle, current_speed * delta)
			if angle_difference > 1: #only increase speed if angle difference is large/if "fast" spinning is occurring
				current_speed = min(current_speed + angle_difference * delta, max_speed)
			else:
				#Subtracting speed here needs to happen because speed can be stored
				pass
		else:
			angle = lerp_angle(angle, angle + previous_angle_difference, current_speed * delta)
			current_speed = max(current_speed - deacceleration * delta, 0)
	else:
		angle = lerp_angle(angle, angle + previous_angle_difference, current_speed * delta)
		current_speed = max(current_speed - (deacceleration * 2) * delta, 0)

#anything that needs to happen when lassoing begins goes here
func start_lasso():
	lasso_in_use = true

#anything that needs to happen when lassoing ends goes here
func end_lasso():
	lasso_in_use = false
	player_two_connected = false
	player2.freeze = false
	player2.sling((player2.position - player1.position).normalized(), current_speed, player2.global_position)

func _input(event: InputEvent) -> void:
	match device_num:
		-1: #keyboard and mouse
			if Input.is_action_just_pressed("mouse_left"):
				start_lasso()
			elif Input.is_action_just_released("mouse_left"):
				end_lasso()
		_: #controller
			if Input.get_joy_axis(device_num, JOY_AXIS_TRIGGER_RIGHT) > 0.1 and !lasso_in_use:
				start_lasso()
			elif Input.get_joy_axis(device_num, JOY_AXIS_TRIGGER_RIGHT) < 0.1 and lasso_in_use and player_two_connected:
				end_lasso()


func _process(delta):
	#Movement logic
	var movement_direction: Vector2 = get_movement_direction()
	if movement_direction.length() > input_sensitivity:
		current_movement_speed = min(current_movement_speed + 15 * delta, MAX_MOVEMENT_SPEED)
		velocity = movement_direction * current_movement_speed
		move_and_slide()
	else:
		current_movement_speed = STARTING_MOVEMENT_SPEED#max(movement_speed - 15 * delta, 0)
	
	#Spin logic
	if player_two_connected:
		match device_num:
			-1: #keyboard and mouse
				var mouse_position: Vector2 = get_global_mouse_position()
				var mouse_angle = get_angle_to(mouse_position)
				spin_logic(true, mouse_angle, delta)
			_: #controller
				var spin_direction: Vector2 = Vector2(Input.get_joy_axis(device_num, 2), Input.get_joy_axis(device_num, 3))
				var is_input_large = spin_direction.length() > input_sensitivity
				var target_angle = spin_direction.angle()
				spin_logic(is_input_large, target_angle, delta)
		target_position.x = player1.position.x + radius * cos(angle)
		target_position.y = player1.position.y + radius * sin(angle)
		player2.global_position = target_position
	
	if lasso_in_use:
		if round(line.points[1]).distance_to(round(player2.position)) > 10 and !player_two_connected:
			line.points = [player1.position, lerp(line.points[1], player2.position, 15 * delta)]
		else:
			if !player_two_connected:
				radius = player1.position.distance_to(player2.position)
				angle = player1.position.angle_to_point(player2.position)
				current_speed = 0
				player2.freeze = true
				player_two_connected = true
			line.points = [player1.position, player2.position]
	else:
		line.points = [player1.position, lerp(line.points[1], player1.position, 15 * delta)]
