// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

//Iniciar o efeito do brilho
//Você usa essa função para inicializar as variáveis necessárias
//Para o efeito de brilho
function inicia_efeito_brilho()
{
    xscale = 1;
    yscale = 1;
    dir    = 1;
    
    alpha_brilho     = 0;
    cor_brilho       = c_white;
}

//Aplicando o efeito de brilho
//Você usa essa função para fazer ele brilhar
//Você também pode definir uma cor aqui
//Você também pode definir a intencidade do brilho
//1 é mais forte e 0 é inexistente
function aplica_efeito_brilho(_cor = c_white, _valor = 1)
{
    alpha_brilho = _valor;
    cor_brilho = _cor;
}

//Retornando para a cor original
//Você usa essa função no step para ele deixar de brilhar
//Você também pode mudar a velocidade com que ele diminui o brilho
//1 é instantaneo e 0 nunca faz nada
function retorna_efeito_brilho(_vel = 0.1)
{
    alpha_brilho = lerp(alpha_brilho, 0, _vel);
}


//Função usada para desenhar o efeito do brilho
//Você deve usar essa função DEPOIS de desenhar a sua sprite
//Você também pode fazer ela manualmente usando as variáveis
//alpha brilho no alpha e cor brilho no image blend
function desenha_efeito_brilho()
{
    //Só preciso me desenhar se o alpha brilho for maior do que 0
    //Se o alpha brilho não for maior do que 0 eu saio da função
    if (alpha_brilho <= 0.01) return;
    
    
    shader_set(sh_muda_cor);
    draw_sprite_ext(sprite_index, image_index, x, y, xscale * dir, yscale, image_angle, cor_brilho, alpha_brilho);
    shader_reset();
}




