/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
//Criando a minha particula


//Criando meu sistema de particulas, no lugar errado!!
ps = part_system_create(ps_brilho_chamas);

part_system_position(ps, x, y);


//Criando a sprite na minha frente
layer_sprite_create("Decoracoes", x, y, sprite_index);