if (room == rmInit || room == rmMainMenu || oGameManager.dead || oFade.currentFade != 0) return;
var sx = window_mouse_get_x();
var sy = window_mouse_get_y();
if (grappling)
{
	var currentChar = oGameManager.current_character();
	draw_sprite_ext(sCrosshairGrappling, currentChar.state == playerState.missedHook ? 1 : 0, sx, sy, 2, 2, 
		point_direction(currentChar.x, currentChar.y, currentChar._gX, currentChar._gY), col, 1);
}
else if (tryingToGrapple)
{
	var currentChar = oGameManager.current_character();
	draw_sprite_ext(sCrosshairGrappling, 1, sx, sy, 2, 2, 
		point_direction(currentChar.x, currentChar.y, mouse_x, mouse_y), col, 1);	
	var progress = 1 - (currentChar._grappleCooldown / (currentChar.grappleCooldown * room_speed));
	
	draw_set_alpha(1);
	draw_set_color(c_dkgray);
	draw_rectangle(sx - 35, sy + 20, sx + 35, sy + 30, false);
	draw_set_color(c_white);
	draw_rectangle(sx - 35, sy + 20, (sx - 35) + (70 * progress), sy + 30, false);
}
else if (reloading)
	draw_circular_bar(sx, sy, reloadPercent, 1, col, 10, 1, 2);
else
	draw_sprite_ext(sprite_index, 0, window_mouse_get_x(), window_mouse_get_y(), 0.5, 0.5, 0, col, 1);

