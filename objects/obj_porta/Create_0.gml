/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

estado = "fechada";

//ps_porta_abrindo
ps = part_system_create();
part_system_draw_order(ps, true);

//Emitter
ptype1 = part_type_create();
part_type_shape(ptype1, pt_shape_smoke);
part_type_size(ptype1, 1, 1, 0.1, 0);
part_type_scale(ptype1, 0.1, 0.1);
part_type_speed(ptype1, 0.1, 0.1, 0.01, 0);
part_type_direction(ptype1, 2, 181, 0, 0);
part_type_gravity(ptype1, 0, 270);
part_type_orientation(ptype1, 0, 0, 0, 0, false);
part_type_colour3(ptype1, $000000, $4C4C4C, $333333);
part_type_alpha3(ptype1, 1, 1, 0.051);
part_type_blend(ptype1, true);
part_type_life(ptype1, 20, 40);





//Estado fechada
maquina_estados = function()
{
    switch(estado)
    {
        //Estado da porta fechada
        case "fechada":
        {
            
        }
        //Terminei o estado eu dou break
        break;
        
        //Estado da porta abrindo
        case "abrindo":
        {
            //Vou subir para cima
            vspeed = -0.3;
            
            //Vou criar o meu sistema de particulas SE 
            //O sistema ainda não existe
            //if (!part_system_exists(ps))
            //{
                ////Eu crio o sistema de particulas
                //ps = part_system_create(ps_porta_abrindo);
                ////Colocando ele na posição correta
                //part_system_position(ps, x, y - sprite_height / 2);
            //}
            
            //Criando a minha particula manualmente
            var _x = x + random_range(-sprite_width / 1.5, sprite_width / 1.5);
            part_particles_create(ps, _x, ystart - sprite_height, ptype1, 1);
            
            
            //Vou tremer a tela
            screenshake(3);
            
            x = xstart + random_range(-1, 1);
            
            //Checando se eu já subi 32 pixels
            if (y < ystart - 33)
            {
                //Eu subi a minha altura inteira
                //Vou para o estado de aberta
                estado = "aberta";
                
                //Mudei de estado, eu mando ele rodar o alarme em 1 segundo
                alarm[0] = FPS;
            }
        }
        break;
        
        
        //Estado da porta aberta, aqui ela não faz nada
        case "aberta":
        {
            
            //Vou apagar o meu sistema de particulas
            //part_system_destroy(ps);
            //Eu paro mano!!!
            vspeed = 0;
            
            
            
            //Volto para a posição x inicial
            x = xstart;
            
        }
        break;
        
    }
}


//Estado abrindo
//A porta vai subir até liberar o caminho do jogador


//Aberta
//Aqui é o estado terminal dela, ela para e pronto