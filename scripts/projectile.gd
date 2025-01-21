extends CharacterBody2D
@export var speed = 100
var spawnPos : Vector2
var dir : float
var is_set =false
# Called when the node enters the scene tree for the first time.
func _ready():
	#global_position = spawnPos
	#rotation = dir
	pass
	

func set_params():
	position = spawnPos
	global_rotation = dir
	#rotation = dir
	is_set = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_set:
		set_params()
	velocity = Vector2(0, -speed).rotated(dir)
	move_and_slide()



func _on_area_2d_body_entered(body: Node2D):
	print("HIT!")
	queue_free()


func _on_life_timeout():
	#print("hi")
	queue_free()
