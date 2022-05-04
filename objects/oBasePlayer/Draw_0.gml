/// @description Insert description here

draw_self();

switch(state)
{
	case playerState.shootingHook:
	case playerState.grappling:
		draw_line_width_color(x, y, _gX, _gY, 1, c_black, c_dkgray);
		draw_rectangle(_gX - 1, _gY - 1, _gX + 1, _gY + 1, false);
		break;
}

