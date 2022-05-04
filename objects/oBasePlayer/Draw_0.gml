/// @description Insert description here

draw_self();

switch(state)
{
	case playerState.shootingHook:
	case playerState.grappling:
		var gX = lengthdir_x(_currentHookLen, _hookDir) + x;
		var gY = lengthdir_y(_currentHookLen, _hookDir) + y;
		draw_line_width_color(x, y, gX, gY, 1, c_black, c_dkgray);
		draw_rectangle(gX - 1, gY - 1, gX + 1, gY + 1, false);
		break;
}

