extends HBoxContainer
#TODO: Update this script to dynamically update heart number by player max health
var health: int = 10
var max_health: int = 10
var min_health: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_hearts(health)



func update_hearts(current_health: int):
	if current_health > max_health || current_health < min_health:
		return
	elif current_health == max_health:
		for child in get_children():
			child.update_sprite(0)
		return
	var child_to_change: int = current_health/2 
	for i in range(child_to_change):
		get_child(i).update_sprite(0)
	if current_health % 2 == 0:
		get_child(child_to_change).update_sprite(2)
	else:
		get_child(child_to_change).update_sprite(1)
	for i in range(child_to_change+1, 5):
		get_child(i).update_sprite(2)
