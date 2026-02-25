/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//Tremendo a tela!!!
//Alterando a posição X e Y do viewport com base no valor do treme
if (treme > 0.1)
{
	var _x = random_range(-treme, treme);
	var _y = random_range(-treme, treme);
	//Alterando a posição x do viewport
	view_set_xport(view_current, _x);
	
	view_set_yport(view_current, _y);
}
else //cheguei perto de zero, eu zero o valor do treme
{
	treme = 0;
	
	//Garanto que a posição da minha view é zerada também
	view_set_xport(view_current, 0);
	view_set_yport(view_current, 0);
}


//Parando de tremer de pouquinho em pouquinho
treme = lerp(treme, 0, .1);

show_debug_message(treme);