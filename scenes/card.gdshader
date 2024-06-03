shader_type canvas_item;

uniform float time;

void fragment() {
    // Calculate color transition using time
    float t = abs(sin(TIME));
    
    // Calculate RGB values
    vec3 color = vec3(0.0);
    color.r = smoothstep(0.0, 1.0, t - 0.5);
    color.g = smoothstep(0.0, 1.0, t);
    color.b = smoothstep(0.0, 1.0, t + 0.5);
    
    // Output final color
    COLOR = vec4(color, 1.0);
}
