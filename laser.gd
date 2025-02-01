extends Line2D
var damage = 1
@onready var collision = $Area2D/CollisionShape2D 

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("cowboy"):
		body.parent.hurt(body, damage)

func activate():
	pass
