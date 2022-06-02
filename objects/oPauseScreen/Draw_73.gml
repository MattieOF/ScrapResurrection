/// @description Check for pause
if (control_check_pressed(controls.quit))
{
	if (room != rmInit)
	{
		if (paused)
		{
			if (inSubMenu)
				return_to_pause();
			else
				unpause();
		}
		else
			pause();
	}
}

