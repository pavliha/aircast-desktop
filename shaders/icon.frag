#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
};

layout(binding = 1) uniform sampler2D src;

// Use a uniform block for the tint color to be Vulkan-compatible
layout(std140, binding = 2) uniform ColorBlock {
    vec4 tintColor;
};

void main() {
    // Sample the texture for alpha
    float alpha = texture(src, qt_TexCoord0).a;
    
    // Use tint color with the alpha from the source
    fragColor = vec4(tintColor.rgb, alpha * qt_Opacity);
}