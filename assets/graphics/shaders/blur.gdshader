shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : repeat_enable, hint_screen_texture, filter_nearest_mipmap;

void fragment(){
    vec4 color = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.9);
    COLOR = color;
}
