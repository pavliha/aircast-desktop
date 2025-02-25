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
    
    // For SVGs, we need to replace the color while preserving transparency
    // This method works better with SVG icons where the shape is defined by alpha
    fragColor = vec4(tintColor.rgb, texColor.a);
}