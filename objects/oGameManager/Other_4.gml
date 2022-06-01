/// @description Find characters in level

characters = ds_list_create();
currentCharacterIndex = 0;
dead = false;
global.speedChangeBlocked = false;
global.usablesLayer = layer_get_id("Usables");
global.highlightedUsablesLayer = layer_get_id("UsablesHighlighted");
global.screenshakeLayer = layer_get_id("Screenshake");
global.screenshakeEffect = (global.screenshakeLayer == -1 ? undefined : layer_get_fx(global.screenshakeLayer));
global.deathLayer = layer_get_id("Death");
global.deathEffect = (global.deathLayer == -1 ? undefined : layer_get_fx(global.deathLayer));
if (global.deathLayer != undefined)
	fx_set_parameter(global.deathEffect, "g_Intensity", 0);

switch (room)
{
	case rmLevel1:
		global.tileTex = sLevel1TilesetP;
		break;
	default:
		global.tileTex = sLevel1TilesetP;
		break;
}

function set_screenshake(mag)
{
	if (global.screenshakeEffect == undefined)
		return;
	
	fx_set_parameter(global.screenshakeEffect, "g_Magnitude", mag);
}

function get_screenshake()
{
	if (global.screenshakeEffect == undefined)
		return;
	
	fx_get_parameter(global.screenshakeEffect, "g_Magnitude");
}

function index_of_player(player)
{
	for (var i = 0; i < ds_list_size(characters); i++)
		if (characters[| i] == player) return i;
	return -1;
}

function death(playerIndex)
{
	switch_character(playerIndex, false);
	dead = true;
	characters[| playerIndex].active = false;
	hud.shouldDraw = false;
	instance_destroy(oHint);
	window_set_cursor(cr_default);

	alarm[2] = 1 * room_speed;
	alarm[1] = 4 * room_speed;
}

highlightedFx = undefined;

window_set_cursor(cr_none);

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

function current_character()
{
	if (array_length(characters) == 0) return pointer_null;
	else return characters[| currentCharacterIndex];
}

switch_character(0, true);

hud = instance_create_layer(0, 0, layer_create(0, "HUD"), oHUD);
if (ds_list_size(characters) > 0) 
	hud.currentPlayer = characters[| currentCharacterIndex];
hud.shouldDraw = true;

if (global.highlightedUsablesLayer != -1)
{
	highlightedFx = layer_get_fx(global.highlightedUsablesLayer);
}

flynnHookCode = array_create(0);
flynnHookProgress = 0;
array_push(flynnHookCode, "F");
array_push(flynnHookCode, "F");
array_push(flynnHookCode, "W");

alarm[3] = 1;

