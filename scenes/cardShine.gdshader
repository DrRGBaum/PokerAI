shader_type canvas_item; // hours spend on this trivial effect: 14

uniform vec2 center = vec2(0.5);
uniform float size: hint_range(0.0,5.0) = 1.0;
uniform vec2 squishness = vec2(1.0);

uniform vec4 color1 : source_color;
uniform vec4 color2 : source_color;
uniform vec4 color3 : source_color;
uniform vec4 color4 : source_color;
uniform vec4 color5 : source_color;
uniform vec4 colorpick : source_color;

uniform float step1 : hint_range(0.0,1.0) = 0.159;
uniform float step2 : hint_range(0.0,1.0) = 0.182;
uniform float step3 : hint_range(0.0,1.0) = 0.233;
uniform float step4 : hint_range(0.0,1.0) = 0.264;
uniform float step5 : hint_range(0.0,1.0) = 0.265;
uniform float step6 : hint_range(0.0,1.0) = 0.266;

// Noise texture for the shader
uniform sampler2D noise_texture:repeat_enable;
uniform float noise_scale;
uniform float noise_speed;

vec4 rgb_spectrum(float t) {
    float r = sin(t * 6.28318) * 0.5;
    float g = sin(t * 6.28318 + 2.09439) * 0.5 + 0.5;
    float b = sin(t * 6.28318 + 4.18879) * 0.5 + 0.5;
    return vec4(r, g, b, 0.5);
}

void fragment() {
    // Sample noise texture and create a perturbation
    vec2 noise_uv = UV + noise_scale * texture(noise_texture, UV - TIME / (1.0 + noise_speed)).rg;
    
    // Calculate distance with perturbed UV coordinates
    float dist = distance(center * squishness, noise_uv * squishness);
    
    // Calculate animated color
    vec4 anim_color = rgb_spectrum(TIME);
    
    // Color mixing based on distance
    vec4 color = mix(color1, color2, smoothstep(step1 * size, step2 * size, dist));
    color = mix(color, color3, smoothstep(step2 * size, step3 * size, dist));
    color = mix(color, color4, smoothstep(step3 * size, step4 * size, dist));
    color = mix(color, color5, smoothstep(step4 * size, step5 * size, dist));
    color = mix(color, anim_color, smoothstep(step5 * size, step6 * size, dist));
    
    color.a *= 0.3;
    
    COLOR = color;
}