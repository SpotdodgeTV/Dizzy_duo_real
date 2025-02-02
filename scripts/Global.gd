extends Node

#these are set during the player select screen and will be used by each player's script
#>0 are for any devices (controllers) that are connected and -1 will be reserved for mouse and keyboard
var player_one_device_num: int = -1
var player_two_device_num: int = -1
var coop_enabled = false

func _ready() -> void:
	Engine.time_scale = 1
