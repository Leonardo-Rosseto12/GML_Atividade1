/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Iniciando coisas?
inicia_efeito_squash();
inicia_efeito_brilho(c_blue);

#region Variaveis

//Variáveis de movimento
velh         = 0;
max_velh     = velocidade_movimento;
velv         = 0;
max_velv     = forca_pulo;
grav         = gravidade;



//Lista de sprites por estado
lista_sprites = [spr_player_parando, spr_player_idle];
indice_sprite = 0;

//Variaveis do level?
chao = false;
chao_tinta = false;

tile_set_tinta = layer_tilemap_get_id("tl_tinta");

//Variáveis de inputs
right = false;
left  = false;
jump  = false;
paint = false;

timer_buffer_pulo = 6;
buffer_pulo = 0;
coyote_timer = 10;
coyote_jump = coyote_timer;


//Contador de chaves
chaves = 0;

//Tocando só uma vez o som de pulo
toca_som_pulo = true;

//Variáveis de power ups
power_tinta = false;
power_pulo_duplo = false;
power_kamehameha = false;

//Variável com a minha lista de colisões
//Pegando a minha layer
var _layer = layer_tilemap_get_id("tl_level");
colisoes = [obj_parede, _layer];

//Direção que eu estou olhando
dir = 1;

//Variaveis dos estados
estado = noone;




#endregion

#region Métodos


//Método para pegar inputs
pega_input = function()
{
    right = keyboard_check(vk_right);
    left  = keyboard_check(vk_left);
    jump  = keyboard_check_pressed(vk_space);
    paint = keyboard_check_pressed(vk_shift);
}

//Método de movimentação
aplica_velocidade = function()
{
    
    //Checando se eu estou no chão
    checa_chao();
    
    //Aplicando os inputs na velh
    velh = (right - left) * max_velh;
    
    
    //Aplicando a gravidade
    //Se eu estou tocando no chão, eu aplico a gravidade à minha velv
    if (!chao)
    {
        velv += grav;
    }
    //Caso contrario eu zero o meu velv
    else //Estou no chão
    {
        
        velv = 0;
        
        //Vou arredondar a posição do y dele
        y = round(y);
        
        //Se eu apertei espaço, eu pulo
        if (jump)
        {
            coyote_jump = 0;
            velv = -max_velv;
        }
        
        //Se eu estou no chão e tenho coyote jump
        if (buffer_pulo)
        {
            velv = -20;
            buffer_pulo = 0;
        }
        
    }
    
    
    //Limitando a velocidade vertical do player
    velv = clamp(velv, -max_velv, max_velv);
    //show_message(velv);
    
    
    

    
    
}


//Se eu estou DENTRO do one way, eu removo ele da colisão
removendo_colisao_one_way = function()
{
    //Checando se eu estou colidindo com o one way
    if (instance_place(x, y, obj_parede_one_way))
    {
        //Eu vou cehcar se ele esta na minha lista de colisão
        if (array_contains(colisoes, obj_parede_one_way))
        {
            //Eu vou remover ele da lista
            //Pegando o indice dele na lista
            var _ind = array_get_index(colisoes, obj_parede_one_way);
            //Removendo ele da lista
            array_delete(colisoes, _ind, 1);
            
        }
    }
}

ajusta_escala = function()
{
    //Se eu apertei para a direita, eu olho para a direita
    //Se meu velh não for 0, aí eu mudo o xscale
    if (velh != 0) dir = sign(velh);
}

movimento = function()
{
    //Usando o move and collide horizontal
    move_and_collide(velh, velv, colisoes, 4);
    
    //Usando o move and collide vertical
    move_and_collide(0, velv, colisoes, 24);
}

checa_chao = function()
{
    chao = place_meeting(x, y + 1, colisoes);
    
    //Checando se tem tinta
    
    chao_tinta = place_meeting(x, y + 1, tile_set_tinta);
}


aplica_coyote_jump = function()
{
    checa_chao();
    if (!chao) coyote_jump--;
    else coyote_jump = coyote_timer;
}

aplica_buffer_pulo = function()
{
    checa_chao();
    pega_input();
    
    if (!chao && jump) buffer_pulo = timer_buffer_pulo;
        
    if (!chao) buffer_pulo--;
    
}

//Método de pegar chave
pega_chave = function()
{
    chaves++;
}

//Crie o método troca sprite
//Faça ele receber uma sprite como argumento
//Faça ele trocar a sprite se ela ainda não esta sendo usada
//Faça ele resetar a animação
troca_sprite = function(_sprite = spr_parede)
{
    //Checando se eu aina não estou com a sprite correta
    if (sprite_index != _sprite)
    {
        //Troco a sprite
        sprite_index = _sprite;
        //Zero a animação
        image_index  = 0;
    }
}


//Criar um método para checar se a animação acabou
//Ele vai retornar TRUE se a animação acabou
acabou_animacao = function()
{
    var _spd = sprite_get_speed(sprite_index) / FPS;
    if (image_index + _spd >= image_number)
    {
        return true;
    }
}


//Pegando o power up
pega_powerup = function()
{
    estado = estado_powerup_inicio;
    
    //Avisando que eu posso usar o power up
    
}


//Método para fazer a transição de sprites
transicao_sprites = function()
{
    troca_sprite(lista_sprites[indice_sprite]);
        
        //Checando se acabou a animação da sprite atual
        if (acabou_animacao())
        {
            //Eu vou para a próxima sprite da lista
            //Checando se o array ainda tem mais sprites
            var _qtd = array_length(lista_sprites) - 1;
            //Se o indice da sprite ainda não chegou no limite do array, eu posso avançar na lista
            if (indice_sprite < _qtd)
            {
                indice_sprite++;
            }
        }   
}


troca_estado = function(_estado = estado_parado, _lista_sprites = [spr_player_idle])
{
    estado = _estado;
    indice_sprite = 0;
    lista_sprites = _lista_sprites;
}

//Métodos os estados
estado_parado = function()
{
    if (buffer_pulo == 0) velv = 0;
    velh = 0;
    aplica_velocidade();
    
    //Código
    //Lógica
    //Do estado parado
    //troca_sprite(spr_player_idle);
    transicao_sprites();
    
    //Se eu apertei para a esquerda OU para a direita
    //Eu mudo para o estado de movendo
    if (right != left)
    {
        troca_estado(estado_movendo, [spr_player_iniciando_movimento, spr_player_move]);
    }
    
    //Pulei
    if (jump or buffer_pulo)
    {
        //show_message("kkkk");
        troca_estado(estado_pulo, [spr_player_jump_inicia, spr_player_jump_cima]);
        instance_create_depth(x, y, depth - 1, obj_pulo_particula);
        
        //Eu me estico para cima
        efeito_squash(.4, 1.6);
    }
    //Se eu não estou tocando no chão
    //Eu estou no estado de pulo
    if (!chao)
    {
        estado = estado_pulo;
    }
    
    //Quando eu apertar o botão de poder
    //Eu entro na tinta
    //Só posso entrar no estado de tinta SE eu apertei o botão
    //E se eu já peguei o power up
    if (paint && power_tinta && chao_tinta)
    {
        estado = estado_tinta_entrar;
    }
}

abre_porta = function()
{
    //Checando se tem colisão com uma porta
    var _porta = instance_place(x +velh, y, obj_porta);
    
    //Se houve colisão com a porta eu faço alguma coisa
    if (_porta)
    {
        //Vou checar se eu tenho chaves
        //Checar se a porta ta no estado de fechada também
        //Checando se a porta ta no estado correto
        if (chaves > 0 && _porta.estado == "fechada")
        {
            //Vou destruir a porta
            //instance_destroy(_porta);
            _porta.estado = "abrindo";
            //Ele vai avisar a porta que ela mudou de estado
            
            //Perco a minha chave
            chaves--;
        }
    }
}


//Crie o estado de movendo
//Ele vai ficar na cor azul
estado_movendo = function()
{
    aplica_velocidade();
    //Eu ainda NÃO mudei a sprite
    //Eu não estou usando a sprite correta
    //show_message(sprite_get_name(sprite_index));
    //Definindo a sprite
    transicao_sprites();
    
    abre_porta();
    
    
    //Voltando para o estado de parado
    //Se eu não estou me movendo, eu provavelmente estou parado
    if (velh == 0)
    {
        troca_estado(estado_parado, [spr_player_parando, spr_player_idle]);
    }
    
    
    if (jump)
    {
        troca_estado(estado_pulo, [spr_player_jump_inicia, spr_player_jump_cima]);
        instance_create_depth(x, y, depth - 1, obj_pulo_particula);
    }
    
    //Se eu não estou no chão, eu estou caindo, estou no estado de pulo
    if (!chao)
    {
        estado = estado_pulo;
    }
    
    //Se eu apertei o botão
    //Se eu tenho o power up
    //Se eu estou no tile da tinta
    if (paint && power_tinta && chao_tinta)
    {
        estado = estado_tinta_entrar;
        
    }
}

//Crie o estado de pulo
//Ele vai ficar na cor amarela
estado_pulo = function()
{
    if (coyote_jump)
    {
        if (jump)
        {
            velv = -max_velv;
            instance_create_depth(x, y, depth - 1, obj_pulo_particula);
        
            //Eu me estico para cima
            efeito_squash(.4, 1.6);
        }
    }
    if (toca_som_pulo && velv < 0) 
    {
        toca_som(som_pulo, .4);
        toca_som_pulo = false;
    }
    aplica_velocidade();
    //Definindo a sprite
    //troca_sprite(spr_player_jump_cima);
    
    
    //Se eu bater na parede subindo eu zero a minha velv
    //Só vou contar a parede e o tileset do level
    var _layer = layer_tilemap_get_id("tl_level");
    var _colisoes = [obj_parede, _layer];
    if (place_meeting(x, y + sign(velv), _colisoes))
    {
        velv = 0;
    }
    
    //Como eu sei que eu vou usar a sprite de jump cima (subindo)
    //Se eu estou subindo, minha velv é negativa
    if (velv < 0)
    {
        transicao_sprites();
        //Removendo o parede one way da lista
        //Se o objeto parede one way existe no meu array, eu removo ele
        //Checando se nas minha colisões o parede one way esta lá
        if (array_contains(colisoes, obj_parede_one_way))
        {
            //Removendo o parede one way das minhas colisões
            //Achando a posição do parede one way
            var _ind = array_get_index(colisoes, obj_parede_one_way);
            //Deletando o meu mano one way do array
            array_delete(colisoes, _ind, 1);
        }
    }
    //Como eu sei que eu vou usar a sprite de jump baixo (caindo)
    else //Estou caindo - Velv é positiva ou 0
    {
        //Fazendo ele trocar a lista de sprites
        lista_sprites = [spr_player_jump_inicio_queda, spr_player_jump_baixo];
        transicao_sprites();
        //Se eu não estou tocando na parede one way
        //Eu preciso checar que eu NÃO estou colidindo com a parede one way
        if (!place_meeting(x, y, obj_parede_one_way))
        {
            //Eu vou colocar o parede one way na minha array
            //Só coloco ele no array SE ele ainda não esta no array
            //Checando se o parede one way NÃO esta no meu array
            if (!array_contains(colisoes, obj_parede_one_way))
            {
                array_push(colisoes, obj_parede_one_way);
            }
            
            //colisoes[2] = obj_parede_one_way;
        }
    }
    
    
    
    
    
    
    //Como eu sei que eu voltei para o estado de parado?
    //Se eu toquei no chão, eu não estou mais pulando
    if (chao)
    {
        toca_som_pulo = true;
        troca_estado(estado_parado, [spr_player_pousando, spr_player_idle]);
        instance_create_depth(x, y, depth - 1, obj_pouso_particula);
        
        //Vou ficar meio achatado
        efeito_squash(1.5, 0.5);
        image_blend = c_white;
    }
}


//Crie os estados da animação no começo
estado_powerup_inicio = function()
{
    troca_sprite(spr_player_powerup_inicio);
    
    //Meu mano tem que ficar parado
    velh = 0;
    velv = 0;
    
    //Indo para o meio da animação
    //Quando a animação desse estado acabou, eu mudo de estado
    if (acabou_animacao())
    {
        estado = estado_powerup_meio;
    }
    
}
//Meio
estado_powerup_meio = function()
{
    troca_sprite(spr_player_powerup_meio);
    
    
    
    //Eu só vou sair do estado de power up meio SE não existe mais particula do power up
    if (!instance_exists(obj_particula_powerup))
    {
        estado = estado_powerup_fim;
    }
    
    
    //Trocando para o estado do fim da animação
    //if (acabou_animacao())
    //{
        //estado = estado_powerup_fim;
    //}
}

//Fim
estado_powerup_fim = function()
{
    troca_sprite(spr_player_powerup_fim);
    
    
    //Finalizando a animação
    if (acabou_animacao())
    {
        troca_estado(estado_parado, [spr_player_idle]);
    }
}

//Estado entrando na tinta
//Entrar no estado do loop da tinta
estado_tinta_entrar = function()
{
    velh = 0;
    troca_sprite(spr_player_tinta_entrar);
    
    //Se a minha particula não existe, eu crio ela
    if (!instance_exists(obj_tinta_entrar_particula))
    {
        //Crio a minha particula
        instance_create_depth(x, y, depth - 1, obj_tinta_entrar_particula);
    }
    
    //Acabou a animação de entrando na tinta
    //Eu entro na tinta
    if (acabou_animacao())
    {
        troca_estado(estado_tinta_loop, [spr_player_tinta_inicio, spr_player_tinta_loop]);
    }
}



//Estado do tinta loop
//Esse estado quando eu apertar o botão de poder?
//Ele vai ir para o estado de tinta sair
estado_tinta_loop = function()
{
    transicao_sprites();
    aplica_velocidade();
    
    var _teto = place_meeting(x, y - 20, colisoes);
    
    //Garantindo que mesmo que o jogador aperte o botão de pulo
    //O velv não vai ser alterado
    velv = 0;
    
    //Eu vou ter a mascara de colisão menor
    mask_index = spr_player_tinta_loop;
    
    
    //Se na minha frente embaixo de mim não tiver chão, eu zero meu velh
    var _parar = !place_meeting(x + (sign(velh) * 18), y + 1, tile_set_tinta);
    if (_parar)
    {
        velh = 0;
    }
    
    //Se eu apertei o botão de tinta, eu saio da tinta
    if (paint && !_teto)
    {
        troca_estado(estado_tinta_sair, [spr_player_tinta_fim, spr_player_tinta_sair]);
        //Criando as particulas
        instance_create_depth(x, y, depth - 1, obj_tinta_sair_particula);
    }
}


//Estado saindo da tinta
//Terminou a animação, ele vai para o estado de parado
estado_tinta_sair = function()
{
    velh = 0;
    
    
    
    //A minhas mascara de colisão volta ao original
    mask_index = spr_player_idle;
    
    
    
    //Terminou a animação, eu vou para o estado de parado
    //Checando se ele chegou no final do array
    var _qtd = array_length(lista_sprites) - 1;
    if (acabou_animacao() && indice_sprite >= _qtd)
    {
        troca_estado(estado_parado, [spr_player_idle]);
    }
    
    transicao_sprites();
}


#endregion


#region debug


view_player = noone;

//Método de debug do jogo
roda_debug = function()
{
    
    
    //Se não ta em debug, ele só sai do método
    //if (!global.debug) return;
        
    
    show_debug_overlay(1);
    
    
    //Criando meus bagui de debug dentro do view
    view_player = dbg_view("View player", 1, 40, 100, 300, 400);
    
    //Vendo as informações da minha velv
    var _ref_velv = ref_create(id, "velv");
    dbg_watch(_ref_velv, "velv");
    
    //Podendo mudar o max velv
    dbg_slider(ref_create(id, "max_velv"), 0, 10, "Max velv", .1);
    
    //Podendo mudar o valor da grav
    dbg_slider(ref_create(id, "grav"), 0, 1, "Gravidade", 0.01);    
}

ativa_debug = function()
{
    
    //SE o jogo não esta no modo debug, ele não faz nada do debug
    if (!DEBUG_MODE) return
    
    
    //Alterando o modo debug
    if (keyboard_check_pressed(vk_tab))
    {
        //Se o debug é true ele vira false, se é false ele vira true
        global.debug = !global.debug;
        
        
        //Se o jogo esta no modo debug, eu rodo o debug
        if (global.debug)
        {
            roda_debug();
        }
        else
        {
            //Desativo o debug overlay
            show_debug_overlay(0);
            //Se a minha view existe e eu não estou no modo debug, eu deleto ela
            if (dbg_view_exists(view_player))
            {
                dbg_view_delete(view_player);
            }
        }
        
    }    
    
    
}

#endregion


//As ultimas coisas que eu faço no meu create
//Definindo o estado inicial do player
estado = estado_parado;

