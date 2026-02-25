/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
//Eu só vou rodar meu código, se eu tenho um alvo

if (!alvo) exit;
    
//Alternando o alpha com base na velocidade
image_alpha = speed / 6;
//ISso só roda se eu tenho alvo

//Eu vou me esticar com base na minha velocidade
image_xscale = lerp(image_xscale, speed * 3, 0.1);
image_angle = direction;

//Se eu ainda não estou voltando, eu diminuo a velocidade
//Preciso perder velocidade
if (voltar == false)
{
    speed -= 0.1;
    
    //Checando se eu já zerei a minha velocidade
    if (speed <= 0)
    {
        //Aviso que já estou voltando
        voltar = true;
        
        //Definindo a direção aqui, porque esse código só roda uma vez
        var _x = alvo.x + random_range(-5, 5);
        var _y = alvo.y - 12 + random_range(-5, 5);
        var _dir = point_direction(x, y, _x, _y);
        direction = _dir;
    }
}
else
{
    //Se eu já estou voltando, eu não preciso diminuir a minha velocidade, mas eu preciso ir na direção
    //Do jogador
    //E agora eu preciso ganhar velocidade
    
    //Vou ganhar velocidade meu mano!
    speed += 0.2;
    
    //Só vou rodar isso DEPOIS de ter perdido toda a minha velocidade
    //Deixando a direção meio aleatória

    //Se eu colidi com o player, eu me destruo
    var _player = instance_place(x, y, obj_player)
    
    
    //Se eu colidi com o player
    if (_player)
    {
        //Eu me destruo
        //Fazendo o efeito de mola com o player
        with(_player)
        {
            var _xscale = random_range(-0.3, 0.3);
            var _yscale = random_range(-0.3, 0.3);
            efeito_squash(1 + _xscale, 1 + _yscale);
            
            //Fazendo o efeito de brilho
            aplica_efeito_brilho();
        }
        
        
        //Dando um screenshake
        screenshake(2);
        
        instance_destroy();
    }
    
}