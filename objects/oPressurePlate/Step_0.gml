/// @description Check for pressed

if (instance_place(x, y, triggerObj))
{
	if (!pressed)
		audio_play_sound(noone, 0, false);
	pressed = true;
}
else
{
	if (pressed)
		audio_play_sound(noone, 0, false);
	pressed = false;
}
	
image_index = pressed ? 1 : 0;

