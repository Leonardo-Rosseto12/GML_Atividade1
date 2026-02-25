/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
if (audio_exists(musica_fundo))
{
    if (!audio_is_playing(musica_fundo))
    {
        var _musica = audio_play_sound(musica_fundo, 0, 1, 0);
        audio_sound_gain(_musica, 1, 2700);
        
    }
}