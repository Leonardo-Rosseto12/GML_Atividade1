// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function inicia_efeito_squash()
{
	//Iniciando as variaveis que eu vou usar
	xscale = 1;
	yscale = 1;
}

//Ele vai definir qual valor vai ter o meu "amassar"
function efeito_squash(_xscale = 1, _yscale = 1)
{
	xscale = _xscale;
	yscale = _yscale;
}

function retorna_squash(_qtd = .1)
{
	xscale = lerp(xscale, 1, _qtd);
	yscale = lerp(yscale, 1, _qtd);
}

function desenha_efeito_squash()
{
	draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);	
}