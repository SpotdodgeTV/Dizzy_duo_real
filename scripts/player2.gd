extends RigidBody2D

const MAGNITUDE = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func sling(direction, speed, nposition):
	global_position = nposition
	apply_impulse(direction * (speed * MAGNITUDE), nposition)
