/// @description Skip intro please

if (control_check_pressed(controls.quit))
{
	global.skipIntro = true;
	save_options();
	intro_complete();
}

