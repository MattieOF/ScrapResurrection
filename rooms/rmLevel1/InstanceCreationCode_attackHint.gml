/// @description Initialise hint text
set_text(scribble(format_string("[fntUiMain][fa_middle][fa_center][c_white]Use [c_yellow][[{0}] [c_white]to attack\n",
	control_get_string(controls.primaryFire))));
add_required_control(controls.primaryFire);

