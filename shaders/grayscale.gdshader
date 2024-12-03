shader_type canvas_item;

const vec4 COLOR_0 = vec4(0.0, 0.0, 0.0, 1.0);      // #000000
const vec4 COLOR_1 = vec4(0.333, 0.333, 0.333, 1.0); // #555555
const vec4 COLOR_2 = vec4(0.667, 0.667, 0.667, 1.0); // #aaaaaa
const vec4 COLOR_3 = vec4(1.0, 1.0, 1.0, 1.0);      // #ffffff

float get_luminance(vec4 color) {
    return 0.299 * color.r + 0.587 * color.g + 0.114 * color.b;
}

vec4 find_closest_palette_color(float lum) {
    float d0 = abs(lum - get_luminance(COLOR_0));
    float d1 = abs(lum - get_luminance(COLOR_1));
    float d2 = abs(lum - get_luminance(COLOR_2));
    float d3 = abs(lum - get_luminance(COLOR_3));
    
    float min_dist = min(min(d0, d1), min(d2, d3));
    
    if (min_dist == d0) return COLOR_0;
    if (min_dist == d1) return COLOR_1;
    if (min_dist == d2) return COLOR_2;
    return COLOR_3;
}

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
    if (original_color.a < 0.5) {
        COLOR = vec4(0.0);
    }
    
    float lum = get_luminance(original_color);
    COLOR = find_closest_palette_color(lum);
    COLOR.a = original_color.a;
}