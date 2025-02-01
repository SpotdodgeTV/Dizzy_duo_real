extends "res://scripts/enemy.gd"
@onready var ray_caster = $RayCast2D
@onready var laser = $Laser

func _ready():
	enemy_setup()
	laser.default_color = laser.INVIS
	ray_caster.add_exception(players[0])
	ray_caster.add_exception(players[1])

func shoot_attack(attack):
	var ray_point = ray_caster.get_collision_point()
	var dist = sqrt(ray_point.x * ray_point.x + ray_point.y * ray_point.y)
	laser.points[0] = position
	laser.points[1].x = dist
	laser.global_rotation_degrees = global_rotation_degrees - 90
	laser.activate()
