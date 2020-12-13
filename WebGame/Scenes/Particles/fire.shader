shader_type canvas_item;
render_mode unshaded, blend_mix;

uniform sampler2D noise_1;
uniform sampler2D noise_2;

uniform float inner = 0.7;
uniform float outer = 0.3;
uniform float circle_scale = 0.3;
uniform float pixel_count = 0.3;


uniform vec4 inner_color : hint_color;
uniform vec4 outer_color : hint_color;

void fragment()
{
	vec2 uv = floor(UV.xy * pixel_count) / pixel_count;
	
	float n1 = texture(noise_1, uv + vec2(TIME * 0.25, TIME * 1.0)).r;
	float n2 = texture(noise_2, uv + vec2(TIME * 0.5, TIME * 2.0)).r;
	
	float fn = (n1 + n2) / 2.0;
	float d = length(circle_scale*(UV.xy - 0.5));
	d = sqrt(1.0 - d*d);
	d = clamp(d, 0.0, 1.0);
	fn *= d;
	
	if (fn < outer)
		COLOR = vec4(0.0);
	else if (fn < inner)
		COLOR = outer_color;
	else
		COLOR = inner_color;
	
	//COLOR.rgb = vec3( d);
	COLOR.a = d*d;
}