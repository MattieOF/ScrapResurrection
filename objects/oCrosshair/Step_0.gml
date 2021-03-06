/// @description Update crosshair position and colour
x = mouse_x;
y = mouse_y;

if (collision_point(x, y, oBaseEnemy, false, true))
	col = c_red;
else if (collision_point(x, y, oBasePlayer, false, true))
	col = c_green;
else
	col = c_white;

if (instance_exists(oGameManager))
{
	grappling = false;
	tryingToGrapple = false;
	
	var currentChar = oGameManager.current_character();
	if (currentChar != undefined && variable_struct_exists(currentChar.current_weapon().weapon, "reloadTime"))
	{
		var reloadTime = currentChar.current_weapon().weapon.reloadTime * room_speed;
		reloading = currentChar.reloading;
		reloadPercent = (reloadTime - currentChar.reloadTime) / reloadTime;
	}
	if (currentChar != undefined && (currentChar.state == playerState.grappling || currentChar.state == playerState.missedHook || currentChar.state == playerState.shootingHook))
	{
		grappling = true;
		col = color_lerp(currentChar.grappleEndCol, currentChar.grappleStartCol, 0.5);
	}
	else if (currentChar != undefined && control_check(controls.grapplingHook))
	{
		tryingToGrapple = true;
		col = color_lerp(currentChar.grappleEndCol, currentChar.grappleStartCol, 0.5);
	}
}

