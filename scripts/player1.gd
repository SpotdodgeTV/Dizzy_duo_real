extends CharacterBody2D

@onready var player1 = self
@onready var player2 = $"../Player2"
@onready var line = $"../Line2D"

var lasso_in_use = false
var player_two_connected = false

var current_movement_speed = 100
var max_movement_speed = 150
var radius = 100.0
var max_speed = 10.0
var deacceleration = 2.0
var current_speed = 0.0
var angle = 0.0
var joystick_sensitivity = 0.4
var target_position = Vector2.ZERO
var previous_angle_difference = 0.0

func _input(event: InputEvent) -> void:
	if Input.get_joy_axis(0, JOY_AXIS_TRIGGER_RIGHT) > 0.1 and !lasso_in_use:
		lasso_in_use = true
	elif Input.get_joy_axis(0, JOY_AXIS_TRIGGER_RIGHT) < 0.1 and lasso_in_use and player_two_connected:
		lasso_in_use = false
		player_two_connected = false
		player2.freeze = false
		player2.sling((player2.position - player1.position).normalized(), current_speed, player2.global_position)

func _process(delta):
	#Movement
	var left_joy_x = Input.get_joy_axis(0, 0)
	var left_joy_y = Input.get_joy_axis(0, 1)
	var left_joystick_direction = Vector2(left_joy_x, left_joy_y)
	if left_joystick_direction.length() > joystick_sensitivity:
		current_movement_speed = min(current_movement_speed + 15 * delta, max_movement_speed)
		velocity = left_joystick_direction * current_movement_speed
		#print(velocity)
		move_and_slide()
	else:
		current_movement_speed = 100#max(movement_speed - 15 * delta, 0)
	
	#Spin
	if player_two_connected:
		var right_joy_x = Input.get_joy_axis(0, 2)
		var right_joy_y = Input.get_joy_axis(0, 3)
		var right_joystick_direction = Vector2(right_joy_x, right_joy_y)
		
		print(current_speed)
		if right_joystick_direction.length() > joystick_sensitivity:
			var target_angle = right_joystick_direction.angle()
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
