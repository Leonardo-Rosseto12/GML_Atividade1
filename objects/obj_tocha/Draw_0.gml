/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//draw_self();

//Desenhando meu brilho brilhoso
//Variando a escala da tocha
var _esc = random_range(0, 0.02);
gpu_set_blendmode(bm_add);
draw_sprite_ext(spr_brilho_tocha, 0, x, y, 0.3 + _esc, 0.3 + _esc, 0, c_white, 0.2);
gpu_set_blendmode(bm_normal);
