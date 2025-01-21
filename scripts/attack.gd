extends Node2D
@export var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	var projectiles = get_children()
	for i in projectiles:
		if i.name == "Camera2D":
			continue
		i.spawnPos = i.position
		i.dir = i.global_rotation
		i.speed = speed
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
