/// @description Draw player + grappling hook

draw_self();

switch(state)
{
	case playerState.shootingHook:
	case playerState.grappling:
	case playerState.missedHook:
		draw_line_width_color(x, y, _gX, _gY, 1, grappleStartCol, grappleEndCol);
		draw_rectangle(_gX - 1, _gY - 1, _gX + 1, _gY + 1, false);
		break;
}

