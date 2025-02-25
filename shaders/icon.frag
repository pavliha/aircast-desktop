#version 310 es
precision mediump float;

layout(location = 0) in highp vec2 qt_TexCoord0;
layout(binding = 0) uniform sampler2D src;
layout(set = 0, binding = 1) uniform Uniforms {
    lowp vec4 tintColor;
};

layout(location = 0) out vec4 fragColor;

void main() {
    // Sample the texture color
    vec4 texColor = texture(src, qt_TexCoord0);
    
    // For SVGs, we need to preserve the alpha channel while replacing the color
    // The alpha of the original texture determines the shape
    // Note: This works assuming the SVG is black or has solid colors that should be replaced
    
    // Apply the tint color while preserving the original alpha
    fragColor = vec4(tintColor.rgb, texColor.a * tintColor.a);
    
    // If your SVGs have white areas that should be tinted:
    // For each white pixel (or close to white), use the tint color
    // For darker colors, blend with the tint based on brightness
    float brightness = (texColor.r + texColor.g + texColor.b) / 3.0;
    
    // Calculate how much of the original color to preserve (for non-white areas)
    // This ensures black/gray areas in the SVG remain that way
    vec3 blendedColor = mix(vec3(0.0, 0.0, 0.0), tintColor.rgb, brightness);
    
    // Final color with preserved alpha
    fragColor = vec4(blendedColor, texColor.a * tintColor.a);
}