/// @description Draw player + grappling hook

if (global.drawDebugItems)
{
	draw_set_color(c_gray);
	draw_set_alpha(0.5);
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
	draw_set_color(c_white);
	draw_set_alpha(1);
}

switch(state)
{
	case playerState.shootingHook:
	case playerState.grappling:
	case playerState.missedHook:
		draw_line_width_color(x, y, _gX, _gY, 1, grappleStartCol, grappleEndCol);
		draw_rectangle(_gX - 1, _gY - 1, _gX + 1, _gY + 1, false);
		break;
}

