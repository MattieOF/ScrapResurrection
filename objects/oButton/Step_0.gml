if (!interactable) return;

if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), drawX1, drawY1, drawX2, drawY2))
{
	color = hoverColor;
	if (mouse_check_button(mb_left) || keyboard_check(vk_enter))
		color = clickedColor;
	else if (mouse_check_button_released(mb_left) || keyboard_check_released(vk_enter)) 
	{
		audio_play_sound(sndClick, 0, false);
		if (onPress != undefined) onPress();
	}
} else color = normalColor;
