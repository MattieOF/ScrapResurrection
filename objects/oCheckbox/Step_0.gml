if (!interactable) return;

show_debug_message("active!");

if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x + width / 2 - height, y - (height / 2), x + width / 2, y + (height / 2)))
{
	checkboxColor = hoveredCheckboxColor;
	if (mouse_check_button(mb_left) || keyboard_check(vk_enter))
		checkboxColor = clickedCheckboxColor;
	else if (mouse_check_button_released(mb_left) || keyboard_check_released(vk_enter)) 
	{
		audio_play_sound(sndClick, 0, false);
		checked = !checked;
		if (onToggle != undefined) onToggle(checked);
	}
} else checkboxColor = normalCheckboxColor;
