/// @description Init hint text
set_text(scribble(format_string("[fntUiMain][fa_middle][fa_center][c_white]Use [c_yellow][[{0}] [c_white]to switch character.\n" +
								"\nEach character has different [c_aqua]stats[c_white].\nYou'll need to decide which character to use depending on the situation.", 
	control_get_string(controls.switchCharacter))));
add_required_control(controls.switchCharacter);

