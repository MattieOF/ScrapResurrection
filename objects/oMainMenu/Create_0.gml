/// @description Create menu

alpha = 0;

function continue_game()
{
	with (oMainMenu)
	{
		oFade.fade_out(1);
		set_layer_interactable("MainMenu", false);
		alarm[3] = 1.3 * room_speed;
	}
}

function new_game()
{
	with (oMainMenu)
	{
		oFade.fade_out(1);
		set_layer_interactable("MainMenu", false);
		alarm[2] = 1.3 * room_speed;
	}
}

function start_quit()
{
	with (oMainMenu)
	{
		oFade.fade_out(1);
		set_layer_interactable("MainMenu", false);
		alarm[1] = 1.3 * room_speed;
	}
}

var canContinue = file_exists("save.json");
draw_set_font(fntUiMain);
start_stack("MainMenu", 100, (global.displayHeight / 2) - (((canContinue ? 4 : 3) * 50) / 2), 10, stackDir.vertical, false);
if (canContinue) add_to_stack(create_button(0, 0, 200, 50, "Continue", continue_game, id,,,,,fa_top, fa_left, 0, 1, false));
add_to_stack(create_button(0, 0, 200, 50, "New Game", new_game, id,,,,,fa_top, fa_left, 0, 1, false));
add_to_stack(create_button(0, 0, 200, 50, "Quit", start_quit, id,,,,,fa_top, fa_left, 0, 1, false));
add_stack_spacing(10);
global.ui_currentX += 55;
add_to_stack(create_checkbox(0, 0, "Fullscreen", window_set_fullscreen, window_get_fullscreen(),,,,,,fntUiMain, 0, 1));
end_stack();

alarm[0] = 1;

