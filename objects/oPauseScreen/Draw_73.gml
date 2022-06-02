/// @description Check for pause
if (room == rmInit || room == rmMainMenu) exit;

if (control_check_pressed(controls.quit))
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

