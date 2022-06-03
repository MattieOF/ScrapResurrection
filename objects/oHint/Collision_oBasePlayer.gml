/// @description Begin showing if currently inactive
if (state == 0)
{
	audio_play_sound(sndNotification, 0, false);
	state++;
}

