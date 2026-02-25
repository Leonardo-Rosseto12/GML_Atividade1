/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//Se eu tenho um alvo
//Eu vou começar a ficar transparente até sumir
if (alvo)
{
    image_alpha -= 0.01;
    
    //Se eu sumi por completo eu me destruo
    if (image_alpha <= 0)
    {
        instance_destroy();
    }
}