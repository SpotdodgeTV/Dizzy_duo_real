extends Panel
var dia: Array[Array]
@onready var text_label = $Text
@onready var name_label = $NamePanel/Name

signal dialog_pressed

var dialog1 = {
	1: ["Cowboy", "Hello Knight."],
	2: ["Knight", "Hello Cowboy!"],
	3: ["Cowboy2", "Super long text test to see if it gets faster when the text is longer."]
	}

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("dialog"):
		emit_signal("dialog_pressed")

func play(dialog_name):
	var dialog = self.get(dialog_name)
	
	for key in dialog:
		var tween = create_tween()
		name_label.text = dialog[key][0]
		text_label.visible_ratio = 0
		text_label.text = dialog[key][1]
		tween.tween_property(text_label, "visible_ratio", 1, text_label.text.length() * .01)
		await dialog_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("dialog1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
