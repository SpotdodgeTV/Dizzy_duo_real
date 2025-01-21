extends Area2D

@export var speed = 200
var screen_size
@export var center_point = Vector2.ZERO
var radius = 200
var angle = 0
var rotating = false


# Use a setter method for the center_point that also updates the position
func set_center_point(value):
	center_point = value
	#update_position()

func get_center_point():
	return center_point

func update_position():
	position.x = center_point + radius * cos(angle)
	position.y = center_point + radius * sin(angle)

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	center_point = get_viewport_rect().get_center()
	#center_point = position
	position.x = center_point.x - radius/2 * cos(angle)
	position.y = center_point.y + radius * sin(angle)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	angle = atan2(position.y - center_point.y, position.x - center_point.x)
	if speed < 1200:
		speed *= 1.01
	if Input.is_action_pressed("rotate_clockwise_p2"):
		angle += speed * delta * PI / 180  # Convert speed to radians per second
		rotating = true
	elif Input.is_action_pressed("rotate_counterclockwise_p2"):
		angle -= speed * delta * PI / 180  # Convert speed to radians per second
		rotating = true
		#print(speed)
	else:
		speed = 200
		rotating = false
	#if position.y >= center_point.y-10 && position.y <= center_point.y+10:
		#position.x = center_point.x + radius
	angle = fmod(angle, 2 * PI)
	
	position.x = center_point.x + radius * cos(angle)
	position.y = center_point.y + radius * sin(angle)
	
	position = position.clamp(Vector2.ZERO, screen_size)
	
