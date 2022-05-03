/// @description Toggle draw debug items on keypress
if (control_check_pressed(controls.toggleDebug))
	global.drawDebugItems = !global.drawDebugItems;

// Return if not in debug menu
if (!global.drawDebugItems) return;

if (keyboard_check(vk_delete))
	_currentResetControlsTimer--;
else
	_currentResetControlsTimer = resetControlsTimer;
	
if (_currentResetControlsTimer <= 0 && !controlsJustReset)
{
	reset_controls(true);
	controlsJustReset = true;
	alarm[0] = 5 * room_speed;
}

