/// @description Define functions

function intro_complete()
{
	with (oCamera)
		event_perform(ev_other, ev_room_start);
	room_goto(rmMainMenu);
}

if (global.skipIntro) intro_complete();

