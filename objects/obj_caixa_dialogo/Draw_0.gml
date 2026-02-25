/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
//Me desenhar

draw_self();
//Se eu não devo desenhar o texto, eu saio do evento
if (!desenhar_texto) exit;
//Alinhando o texto
//Definindo a fonte!!!!
/*
draw_set_font(fnt_dialogo);
draw_set_halign(0);
draw_set_valign(0);
//Fazendo o texto voltar metade da sprite
 */
var _marg = 3;
var _x = x - sprite_width/2 + _marg;
var _y = y - sprite_height / 2 + _marg;
var _larg = (sprite_width * 10) - (_marg * 20);
//draw_text_ext_transformed(_x, _y, texto, 60, _larg, .1, .1, 0);
//draw_set_font(-1);
 

//Criando o meu texto do scribble
var _txt = scribble(texto).starting_format("fnt_dialogo", c_white);
//Ajustando a escala
_txt = _txt.scale(0.1);
//Fazendo ele caber na caixa
_txt = _txt.wrap(sprite_width - _marg * 2);

//Desenhando o texto do scrible
_txt.draw(_x, _y, escrevente);