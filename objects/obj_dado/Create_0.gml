/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


estado = noone;

timer = tempo;

contador_estado = function(_estado_destino = estado_setinha)
{
    timer--;
    
    if (timer <= 0)
    {
        timer = tempo;
        estado = _estado_destino;
    }
       
}


//Método do estado setinha
estado_setinha = function()
{
    //Ficar parado na primeira imagem
    image_index = 0;
    
    
    //Minha máscara de colisão volta ao normal
    mask_index = sprite_index;
    
    //Preciso contar e saber que passou 1 segundo
    //Diminuindo o valor do timer
    contador_estado(estado_seta_para_xis);
}


//Estado setinha_para_xis
estado_seta_para_xis = function()
{
    
    
    //Chegou na image index 8, ele vai para o próximo estado
    if (image_index >= 8)
    {
        estado = estado_xis;
    }
}

//Estado do xis
estado_xis = function()
{
    //Ficar na parado na oitava imagem
    image_index = 8;
    
    //Quando estou no xis, minha mascara de colisão vai ser vazia
    mask_index = spr_vazio;
    
    //Diminuir o valor do timer
    contador_estado(estado_xis_para_seta);
}

estado_xis_para_seta = function()
{
    
    //Se acabou a animação, eu vou para o estado da seta
    if (image_index >= image_number - 1)
    {
        estado = estado_setinha;
    }
}

estado = estado_setinha;
//Se o esatdo inicial for xis eu coloco ele no estado xis
if (estado_inicial == "estado_xis")
{
    //Definindo o estado inicial dele
    estado = estado_xis;
}
