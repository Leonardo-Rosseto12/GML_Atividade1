/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Identificando quem é o player
alvo = noone;


metodo_colide_player = function()
{
    if (alvo == noone)
    {
        //Coloco o player no estado correto
        obj_player.pega_powerup();
        //Defino o meu alvo
        alvo = obj_player.id;    
        
        //Vou para a posição correta
        movendo();
        
        explosao();
        
        //Avisando meu mano player que ele pode usar o power up da tinta
        obj_player.power_tinta = true;
    }
}


//Indo para a cabeça do player?
movendo = function()
{
    //Eu só rodo SE somente se eu tiver um alvo
    if (!alvo) return;
        
    //Se eu estou sem alvo, o codigo daqui para baixo não roda
    
    //Esse código só roda se eu tenho alvo
    x = alvo.x;
    y = alvo.y - 34;
    vspeed = 0;
}


//Explosão de particulas
explosao = function()
{
    
    //Criando 20 particulas
    var _qtd = irandom_range(20, 50);
    repeat(_qtd)
    {
        var _part = instance_create_layer(x, y, "Enfeites", obj_particula_powerup);
        _part.speed = random_range(2, 5); //Com uma velocidade entre 0.5 e 2
        _part.direction = random_range(0, 359); //Entre 0 e 359
        
        //Dando o alvo da particula
        _part.alvo = alvo;
        
    }
    
}