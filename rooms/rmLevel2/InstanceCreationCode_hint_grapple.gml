set_text(scribble(format_string("[fntUiMain][fa_middle][fa_center][c_white]Use [c_yellow][[{0}] [c_white]to grapple.\n" +
								"\nThe [c_aqua]grappling hook[c_white] can be used to traverse\nplatforming sections and outmanoeuvre enemies." +
								"\nIt can only be used every few seconds.", 
	control_get_string(controls.grapplingHook))));
add_required_control(controls.grapplingHook);

