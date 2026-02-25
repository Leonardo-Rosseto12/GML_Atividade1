/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
pega_input();

checa_chao();

movimento();
ativa_debug();
ajusta_escala();

retorna_squash();

//Retornando o alpha brilho a zero
retorna_efeito_brilho();
aplica_coyote_jump();
aplica_buffer_pulo(); 
//Rodando o meu estado
estado();

removendo_colisao_one_way();


//Deixando o jogo em tela cheia quando eu apertar o F11
//Ou tirar de tela cheia
if (keyboard_check_pressed(vk_f11))
{
    //Pegando se a tela ta cheia
    var _full = window_get_fullscreen();
    
    //Deixando a tela cheia se ela não esta cheia
    //Ou restaurando a tela se ela esta cheia
    window_set_fullscreen(!_full);
}


//Reiniciando o level
if (keyboard_check_pressed(ord("R")))
{
    cria_transicao_inicia(room);
}

//Sempre que eu apertar espaço, eu vou dar o efeito