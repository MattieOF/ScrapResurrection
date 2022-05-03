/// @description Find characters in level

characters = ds_list_create();
currentCharacterIndex = 0;
global.speedChangeBlocked = false;

with (oBasePlayer)
	ds_list_add(oGameManager.characters, id);

function switch_character(index, instant = false)
{
	show_debug_message("Switching character...");
	
	var size = ds_list_size(characters);
	if (index == size && size > 1)
	{
		// There is at least 1 character, and we are trying to size + 1
		// So switch to the first one
		switch_character(0);
		return;
	}
	if (index >= ds_list_size(characters))
		return;
	
	characters[| currentCharacterIndex].active = false;
	currentCharacterIndex = index;
	log_format_string("Switching to character with index {0}", index);
	if (instance_exists(oCamera))
	{
		oCamera.cameraMoveFractionPerFrame = 25;
		alarm[0] = oCamera.time_to_move_to_target(characters[| currentCharacterIndex]);
		global.speedChangeBlocked = true;
		oCamera.set_target(characters[| currentCharacterIndex], instant);
	}
	characters[| currentCharacterIndex].active = true;
}

switch_character(0, true);

