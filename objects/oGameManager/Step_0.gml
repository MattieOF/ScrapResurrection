/// @description Check for switch character pressed

if (ds_list_size(characters) <= 0) exit;

if (control_check_pressed(controls.switchCharacter))
{
	switch_character(currentCharacterIndex + 1, false);
}

var currentChar = characters[| currentCharacterIndex];
with (currentChar)
{
	var usableCol = instance_place(x, y, oBaseUsable);
	if (usableCol != noone && usableCol.active)
	{
		// Player is in range of a usable
		// 1. Ignore if its not active (done in previous if)
		// 2. If it doesn't require keypress, use it now
		//    2a. If not, show UI
		//    2b. Highlight it
		//    2c. Check for use keypress
	
		if (!usableCol.requireKeyPress)
		{
			oGameManager.hud.showUseText = false;
			usableCol.use(id);
		}
		else
		{
			// Show UI
			oGameManager.hud.update_use_text(usableCol.verb, controls.use, true);
	
			// Highlight it
			if (variable_instance_exists(usableCol, "sprite"))
				usableCol.sprite.layer = global.highlightedUsablesLayer;
			usableCol.highlighted = true;
		
			// Check for use
			if (control_check_pressed(controls.use))
				usableCol.use(id);
		}
	}
	else
		oGameManager.hud.showUseText = false;
}

if (!global.flynnHook)
{
	show_debug_message(keyboard_lastchar);
	show_debug_message(flynnHookProgress);
	show_debug_message(array_length(flynnHookCode));
	
	if(keyboard_lastchar == string_lower(flynnHookCode[flynnHookProgress]))
		flynnHookProgress++;
	else if (keyboard_lastchar != "")
		flynnHookProgress = 0;
	
	keyboard_lastchar = "";
	
	if (flynnHookProgress == array_length(flynnHookCode))
		global.flynnHook = true;
}

//if (highlightedFx != undefined)
//{
//	var col = make_color_hsv((current_time / 50) % 255, 40, 255);
//	fx_set_parameter(highlightedFx, "g_OutlineColour", [color_get_red(col), color_get_green(col), color_get_blue(col), 1]);
//}

