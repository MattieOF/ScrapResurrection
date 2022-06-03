/// @description Initialise hint text
set_text(scribble(format_string("[fntUiMain][fa_middle][fa_center][c_white]Use [c_yellow][[{0}] [c_white]to dash\n"
	+ "While dashing, you are [c_aqua]invulnerable",
	control_get_string(controls.dash))));
add_required_control(controls.dash);

