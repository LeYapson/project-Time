shader_type canvas_item;

// Déclaration de la texture d'écran
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;

// Intensité de la distorsion
uniform float distortion_intensity : hint_range(0.0, 0.1) = 0.02;

void fragment() {
    vec2 uv = SCREEN_UV; // Utilise SCREEN_UV au lieu de UV

    // Distorsion légère basée sur le temps
    uv.x += sin(uv.y * 10.0 + TIME * 3.0) * distortion_intensity;
    uv.y += cos(uv.x * 8.0 + TIME * 2.0) * distortion_intensity;

    // Affiche la scène avec la distorsion
    COLOR = texture(SCREEN_TEXTURE, uv);
}
