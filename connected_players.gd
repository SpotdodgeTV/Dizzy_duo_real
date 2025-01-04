extends Node2D
@export var spawn_point = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_point = get_viewport_rect().get_center()
	$player.set_center_point(spawn_point)
	$player2.set_center_point(spawn_point)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$player.set_center_point($player2.position)
	$player2.set_center_point($player.position)
	$Line2D.points[1] = $player2.global_position
	$Line2D.points[0] = $player.global_position
