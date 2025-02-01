extends Line2D
var damage = 1
@onready var collision = $Area2D/CollisionShape2D
var INVIS = "00000000"
var CHARGING = "d66988b6"
var ACTIVE = Color(2.3,0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	default_color = INVIS
	activate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("cowboy"):
		body.parent.hurt(body, damage)

func activate():
	collision.shape.a = points[0]
	collision.shape.b = points[1]
	default_color = CHARGING
	await get_tree().create_timer(1.5).timeout
	default_color = ACTIVE
	collision.disabled = false
	await get_tree().create_timer(.25).timeout
	collision.disabled = true
	default_color = INVIS
