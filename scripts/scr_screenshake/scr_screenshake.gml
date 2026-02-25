// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
//Função de screenshake
function screenshake(_treme = 1)
{
	//Checando se a instância do objeto screenshake existe
	if (instance_exists(obj_screenshake))
	{
		//Checando se o valor de treme atual é maior do que o treme do
		//Objeto screenshake
		//Acessar o objeto screenshake
		with(obj_screenshake)
		{
			//treme += _treme
			//Meu código vai rodar dentro desse objeto
			//Se o treme novo for maior do que eu estou tremendo
			//Aí eu mudo o valor dele, caso contrário eu não faço nada
			if (_treme > treme)
			{
				treme = _treme;
			}
		}
		//Passando para ele o valor de tremer
		//obj_screenshake.treme = _treme;
	}
    else
    {
        instance_create_depth(0, 0, 0, obj_screenshake);
    }
}