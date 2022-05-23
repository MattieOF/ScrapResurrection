set_text(scribble(format_string("[fntUiMain][fa_middle][fa_center][c_white]Use [c_yellow][[{0}] [c_white]and [c_yellow][[{1}] [c_white]to move\n" + 
	"Use [c_yellow][[{2}] [c_white]to jump\n" + 
	"Use [c_yellow][[{3}] [c_white]to interact with objects", control_get_string(controls.left), control_get_string(controls.right), control_get_string(controls.jump), control_get_string(controls.use))));
add_required_control(controls.left);
add_required_control(controls.right);
add_required_control(controls.jump);
add_required_control(controls.use);

