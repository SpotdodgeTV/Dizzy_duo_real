extends Camera2D

@onready var player_one = get_tree().get_nodes_in_group("cowboy")[0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#global_position.y = clamp(lerp(global_position.y, player_one.global_position.y, delta ), 168, 224)
	global_position.y = clamp(player_one.global_position.y, 168,224)
