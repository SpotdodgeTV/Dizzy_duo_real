extends CanvasLayer
@onready var text_label = $Dialog/Text
@onready var name_label = $Dialog/NamePanel/Name
@onready var name_panel = $Dialog/NamePanel

signal dialog_pressed
signal finished

var dialog1 = {
	1: ["Cowboy", "It's been a real long day of cowboyin..."],
	2: ["Cowboy", "What in tarnation is that?!"],
	3: ["Cowboy", "YEEEEE HAAAWWWWWWW!"]
	}

var dialog2 = {
	1: ["Knight", "Forward, good men! Glory be nigh unto us!"],
	2: ["Knight", "Hark! What be this? 'Tis a strange sort of gateway, it doth seem!"],
	3: ["Knight", "AHHHHHHHH!"]
	}

var tutorial = {
	1: ["Cowboy", "Where am I? Who are you?"],
	2: ["Knight", "Methinks this strange portal doth possess powers of swift travel!"],
	3: ["Cowboy", "You don't have any legs! What happened?!"],
	4: ["Knight", "Methinks I’ve had a wound... yet 'tis but a mere scratch."],
	5: ["Knight", "Mayhap thou canst wield thy lasso yonder and swing me about like a merry fool?"],
	6: ["", "Use left click to have cowboy grab knight with his lasso."],
	7: ["", "Use WASD to move."],
	8: ["", "Use the mouse wheel to increase and decrease the lasso length."],
	9: ["", "Use right click to swing knight's sword to attack and deflect bullets."]
}

var end_cutscene = {
	1: ["", "Cowboy and Knight have escaped the dungeon!"],
	2: ["", "The Cowboy returned to his epic journey through the desert..."],
	3: ["", "And the Knight went to the future to get a sick ass pair of robot legs!"],
	4: ["", "The end."],
}

func _ready() -> void:
	name_panel.visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("dialog"):
		emit_signal("dialog_pressed")

func play(dialog_name, delay = 0, fade_out: bool = false):
	if delay > 0:
		visible = false
		await get_tree().create_timer(delay).timeout
		visible = true
	
	var dialog = self.get(dialog_name)
	
	for key in dialog:
		get_parent().dialog_signal(dialog_name, key)
		var tween = create_tween()
		name_label.text = dialog[key][0]
		name_panel.visible = (!name_label.text == "")
		if name_label.text == "Knight":
			name_label.modulate = Color.ROYAL_BLUE
		elif name_label.text == "Cowboy":
			name_label.modulate = Color.DARK_RED
		text_label.visible_ratio = 0
		text_label.text = dialog[key][1]
		tween.tween_property(text_label, "visible_ratio", 1, text_label.text.length() * .01)
		dialog_noise(tween)
		
		await dialog_pressed
		if text_label.visible_ratio != 1:
			tween.stop()
			text_label.visible_ratio = 1
			await  dialog_pressed
		
		if key == dialog.size():
			emit_signal("finished")
			if fade_out:
				var fade_tween = create_tween()
				fade_tween.tween_property($Dialog, "modulate:a", 0, 1)

func dialog_noise(tween):
	$Blip/AnimationPlayer.play("blip")
	await tween.finished
	$Blip/AnimationPlayer.stop()

func change_blip_pitch():
	$Blip.pitch_scale = randf_range(.7,1.9)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
