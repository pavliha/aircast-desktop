#version 310 es
precision mediump float;
layout(location = 0) in highp vec2 qt_TexCoord0;
layout(binding = 0) uniform sampler2D src;
layout(set = 0, binding = 1) uniform Uniforms {
    lowp vec4 tintColor;
};
layout(location = 0) out vec4 fragColor;
void main() {
    vec4 col = texture(src, qt_TexCoord0);
    fragColor = vec4(col.rgb * tintColor.rgb, col.a * tintColor.a);
}
