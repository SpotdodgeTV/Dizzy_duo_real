extends Control

const section_time = 2.0
const line_time = 1.3
const base_speed = 30
const speed_up_multiplier = 10.0
const title_color = Color.DARK_RED

var logo_font = preload("res://fonts/FreeCheese-Regular.ttf")

var scroll_speed = base_speed
var speed_up = false

@onready var line = $Control/Line
var started = false
var finished = false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

var credits = [
	[
		"Thank you for playing!",
		"Made for the 2025 Boss Rush Game Jam on itch.io",
		"",
		"",
		"",
	],[
		"Dizzy Duo",
		"",
		"",
		"",
	],[
		"Programming",
		"Nico Morin and Brandon Adams",
	],[
		"Music",
		"Jackson Thomas Ward",
		"Max Whittaker",
		"Brandon Adams"
	],[
		"Art",
		"Brandon Adams",
		"Ashleigh Adams",
		"Charlie Rice"
	],[
		"Assets",
		"Free Cheese Font - GGBotNet Free Cheese Font | OpenGameArt.org",
		"Brush Strokes - Dino0040 ~100 grunge brushstrokes and splatters set | OpenGameArt.org",
		"Heart Icon - cdgramos Heart | OpenGameArt.org",
		"Desert Background - PWL Seamless desert background in parts | OpenGameArt.org",
		"Portal - Pixelnauta Pixel Dimensional Portal 32x32 by Pixelnauta",
		"Forest Background - jkjkke Background | OpenGameArt.org",
		"Circle Scene Transition - agurkas Simple circle transition - Godot Shaders",
		"16 bit sound effects - phoenix 1291 SFX: The Ultimate 2017 16 bit Mini pack | OpenGameArt.org",
		"Emoji references - Svor87 Pixelart 16x16 emojis free | OpenGameArt.org",
		"Dungeon Tileset - pebonius Dawngeon | OpenGameArt.org"
	]
]

func _process(delta: float):
	var scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	$Control.global_position.y -= scroll_speed
	if lines.size() > 0:
		for l in lines:
			#print(scroll_speed)
			#l.rect_position.y -= scroll_speed
			if l.global_position.y < -l.get_line_height():
				#print("BAM")
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		$SceneChanger.change_scene("res://scenes/mainmenu.tscn")


func add_line():
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	#if curr_line == 0:
		#new_line.add_font_override("font_color", title_color)
		#if new_line.text == "Residential Crusaders":
			#new_line.add_font_override("font", logo_font)
			#new_line.add_color_override("font_color", Color8(255, 255, 255))
			#new_line.add_color_override("font_color_shadow", Color8(246,0,0))
			#new_line.
	$Control.add_child(new_line)
	new_line.global_position = $Pos.global_position
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false
