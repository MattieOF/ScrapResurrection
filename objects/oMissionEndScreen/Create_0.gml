/// @description Create UI
function next_level()
{
	room_goto(nextRoom);
}

function to_menu()
{
	room_goto(rmMainMenu);
}

function to_desktop()
{
	save(, nextRoom);
	game_end();
}

function init(enemyScore, time, _nextRoom, _color = c_white)
{
	var timeScore = floor(min(lerp(20000, 0, time / 120), 15000));
	nextRoom = _nextRoom;
	
	start_stack("EndMissionScreen", 100, 100, 10, stackDir.vertical, false);
	add_to_stack(create_label(0, 0, "LEVEL COMPLETE.",, _color, fntUiMainMassive, fa_top, fa_left, 0, 1, true));
	add_stack_spacing(100);
	add_to_stack(create_label(0, 0, "Kill score: " + string(enemyScore),, _color, fntUiMainLarge, fa_top, fa_left, 0, 1, true));
	add_to_stack(create_label(0, 0, "Time score: " + string(timeScore),, _color, fntUiMainLarge, fa_top, fa_left, 0, 1, true));
	add_to_stack(create_label(0, 0, "Total score: " + string(enemyScore + timeScore),, _color, fntUiMainLargeBold, fa_top, fa_left, 0, 1, true));
	add_stack_spacing(100);
	add_to_stack(create_button(0, 0, 200, 50, "Next Level", next_level, id,,,,,fa_top, fa_left, 0, 1, true));
	add_to_stack(create_button(0, 0, 200, 50, "Exit to Menu", to_menu, id,,,,,fa_top, fa_left, 0, 1, true));
	add_to_stack(create_button(0, 0, 200, 50, "Exit to Desktop", to_desktop, id,,,,,fa_top, fa_left, 0, 1, true));
	
	end_stack();
}

alpha = 0;

