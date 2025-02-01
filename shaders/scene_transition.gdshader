shader_type canvas_item;
render_mode unshaded;

uniform vec2 pos = vec2(0.5,0.5);
uniform float circle_size : hint_range(0.0, 1.35);
uniform float screen_width = 1152;
uniform float screen_height = 672;

void fragment() {
	float ratio = screen_width / screen_height;
	float dist = distance(pos, vec2(mix(0.5, UV.x, ratio), UV.y));
	COLOR.a = step(circle_size, dist);
}