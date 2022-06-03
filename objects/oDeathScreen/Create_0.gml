/// @description Create menu, init values
function load_checkpoint()
{
	load();
}

function to_menu()
{
	room_goto(rmMainMenu);
}

function to_desktop()
{
	game_end();
}

function init(name)
{
	start_stack("DeathScreen", 100, 100, 10, stackDir.vertical, false);
	add_to_stack(create_label(0, 0, format_string("{0} DIED.", string_upper(name)),, c_red, fntUiMainMassive, fa_top, fa_left, 0, 1, true));
	add_stack_spacing(100);
	add_to_stack(create_button(0, 0, 250, 50, "Load Checkpoint", load_checkpoint,,,,,,fa_top, fa_left, 0, 1, true));
	add_to_stack(create_button(0, 0, 250, 50, "Quit to Menu", to_menu,,,,,,fa_top, fa_left, 0, 1, true));
	add_to_stack(create_button(0, 0, 250, 50, "Quit to Desktop", to_desktop,,,,,,fa_top, fa_left, 0, 1, true));
	end_stack();
}

alpha = 0;

