/// @description Create menu
function restart()
{
	new_save();
}

function to_menu()
{
	room_goto(rmMainMenu);
}

function to_desktop()
{
	game_end();
}

function init(enemyScore, time, _color = c_white)
{
	var timeScore = floor(min(lerp(20000, 0, time / 120), 15000));
	
	start_stack("EndMissionScreen", 100, 100, 10, stackDir.vertical, false);
	add_to_stack(create_label(0, 0, "GAME COMPLETE.",, _color, fntUiMainMassive, fa_top, fa_left, 0, 1, true));
	var _y = global.ui_currentY;
	add_to_stack(create_label(0, 0, "That's all we could make for this prototype - thanks for playing!",, _color, fntUiMain, fa_top, fa_left, 0, 1, true));
	add_stack_spacing(100 - (global.ui_currentY - _y));
	add_to_stack(create_label(0, 0, "Kill score: " + string(enemyScore),, _color, fntUiMainLarge, fa_top, fa_left, 0, 1, true));
	add_to_stack(create_label(0, 0, "Time score: " + string(timeScore),, _color, fntUiMainLarge, fa_top, fa_left, 0, 1, true));
	add_to_stack(create_label(0, 0, "Total score: " + string(enemyScore + timeScore),, _color, fntUiMainLargeBold, fa_top, fa_left, 0, 1, true));
	add_stack_spacing(100);
	add_to_stack(create_button(0, 0, 200, 50, "Play Again", restart, id,,,,,fa_top, fa_left, 0, 1, true));
	add_to_stack(create_button(0, 0, 200, 50, "Exit to Menu", to_menu, id,,,,,fa_top, fa_left, 0, 1, true));
	add_to_stack(create_button(0, 0, 200, 50, "Exit to Desktop", to_desktop, id,,,,,fa_top, fa_left, 0, 1, true));
	
	end_stack();
}

alpha = 0;

