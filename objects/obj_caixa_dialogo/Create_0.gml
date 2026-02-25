/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
texto = "cachorro quente!!!";

//Criando meu typist
escrevente = scribble_typist();
//Configurando a velocidade da digitação do meu mano escrevente
escrevente.in(0.5, 10);


//Ajustando o efeito de wave
scribble_anim_wave(1, 0.6, 0.1);

//Ajustando o efeito de shake
scribble_anim_shake(1, 0.2);

desenhar_texto = false;
me_destruir = false;
image_alpha = 0;
image_xscale = .1;
image_yscale = .1;

//Meu método de inicio
iniciando = function()
{
    image_xscale = lerp(image_xscale, 2.5, .1);
    image_alpha = lerp(image_alpha, .8, .1);
    image_yscale = lerp(image_yscale, 1, .1);
    //Fazendo ele subir um pouquinho
    y = lerp(y, ystart - 30, .2);
    
    //Checando se o y chegou próximo o suficiente da posição final dele
    if (y <= ystart - 29.9)
    {
        desenhar_texto = true;
    }
}

finalizando = function()
{
    //Ficando fino
    image_xscale = lerp(image_xscale, 0, .2);
    
    //Ficando invisivel
    image_alpha = lerp(image_alpha, 0, .1);
    
    image_yscale = lerp(image_yscale, 0, .1);
    
    //Fazendo ele voltar para baixo
    y = lerp(y, ystart, .2);
    
    //eu paro de desenhar meu texto
    desenhar_texto = false;
    
    //Se eu sumi completamente, eu me destruo
    if (image_alpha <= 0.01)
    {
        instance_destroy();
    }
    
}