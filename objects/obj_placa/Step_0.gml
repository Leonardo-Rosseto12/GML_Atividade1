/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//Checando se eu colidi com o player
var _player = place_meeting(x, y, obj_player);

//Se eu colidi com o player, eu vou criar a minha caixa de dialogo
if (_player)
{
    //Se eu ainda não tenho caixa de dialogo
    if (!instance_exists(minha_caixa_dialogo))
    {
        //Agora eu vou criar minha caixa de diálogo
        minha_caixa_dialogo = instance_create_layer(x, y - 10, "dialogo", obj_caixa_dialogo);
        //Vou avisar qual é o texto dela
        minha_caixa_dialogo.texto = texto;
        
    }
}
//Se eu não estou colidindo com o player
else
{
    //Checando se a minha caixa de dialogo existe
    if (instance_exists(minha_caixa_dialogo))
    {
        //Vou destruir o zé ruela
        //Avisando que ela PODE se destruir
        minha_caixa_dialogo.me_destruir = true;
    }
}