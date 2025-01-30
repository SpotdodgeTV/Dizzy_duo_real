extends CanvasLayer

func _ready() -> void:
	$Resume.connect("button_down", the_stuff)
	$Quit.connect("button_down", quit)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		the_stuff()

func the_stuff():
	get_tree().paused = !get_tree().paused
	visible = get_tree().paused

func quit():
	get_tree().quit()
