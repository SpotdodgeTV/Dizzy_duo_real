extends Node2D
@export var speed = 100
@export var stdDelay = .5

# Called when the node enters the scene tree for the first time.
func _ready():
	var projectiles = get_children()
	var localDex = 0
	for i in projectiles:
		if i.name == "Camera2D":
			continue
		
		var currDex = i.projectile_index
		if localDex < currDex:
			localDex=currDex
			await get_tree().create_timer(stdDelay).timeout
			#print(i.get_meta("projectile_index"))
		i.spawnPos = i.position
		i.dir = i.global_rotation
		i.speed = i.speed + speed
		i.set_params()
		i.visible = true
		i.start_timer()
		

		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
