/// @description Check for pause
if (control_check_pressed(controls.quit))
{
	if (room != rmInit)
	{
		if (paused)
			unpause();
		else
			pause();
	}
}

