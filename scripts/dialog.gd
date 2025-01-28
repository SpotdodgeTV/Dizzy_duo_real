extends Panel
var dia: Array[Array]
@onready var text_label = $Text
@onready var name_label = $NamePanel/Name

signal dialog_pressed

var dialog1 = {
	1: ["Cowboy", "It's been a real long day of cowboyin..."],
	2: ["Cowboy", "What in tarnation is that?!"],
	3: ["Cowboy", "YEEEEE HAAAWWWWWWW!"]
	}

var dialog2 = {
	1: ["Knight", "Onward men! Victory is within our grasp!"],
	2: ["Knight", "Huh what is this? This seems to be some kind of portal of sorts!"],
	3: ["Knight", "AHHHHHHHH!"]
	}

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("dialog"):
		emit_signal("dialog_pressed")

func play(dialog_name):
	var dialog = self.get(dialog_name)
	
	for key in dialog:
		get_parent().dialog_signal(dialog_name, key)
		var tween = create_tween()
		name_label.text = dialog[key][0]
		if name_label.text == "Knight":
			name_label.modulate = Color.ROYAL_BLUE
		elif name_label.text == "Cowboy":
			name_label.modulate = Color.DARK_RED
		text_label.visible_ratio = 0
		text_label.text = dialog[key][1]
		tween.tween_property(text_label, "visible_ratio", 1, text_label.text.length() * .01)
		await dialog_pressed
		if text_label.visible_ratio != 1:
			tween.stop()
			text_label.visible_ratio = 1
			await  dialog_pressed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
