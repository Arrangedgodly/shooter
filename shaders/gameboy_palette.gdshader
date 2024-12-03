shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform vec4 target_black : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 target_dark : source_color = vec4(0.2, 0.2, 0.2, 1.0);
uniform vec4 target_light : source_color = vec4(0.8, 0.8, 0.8, 1.0);
uniform vec4 target_white : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
    vec4 screen_color = texture(screen_texture, SCREEN_UV);
    
    // Check which grayscale value we're closest to
    if (distance(screen_color, vec4(0.0, 0.0, 0.0, 1.0)) < 0.1) {
        COLOR = target_black;
    } else if (distance(screen_color, vec4(0.333, 0.333, 0.333, 1.0)) < 0.1) {
        COLOR = target_dark;
    } else if (distance(screen_color, vec4(0.667, 0.667, 0.667, 1.0)) < 0.1) {
        COLOR = target_light;
    } else if (distance(screen_color, vec4(1.0, 1.0, 1.0, 1.0)) < 0.1) {
        COLOR = target_white;
    } else {
        COLOR = screen_color;
    }
    
    COLOR.a = screen_color.a;
}