if (global.drawDebugItems)
{
	draw_set_color(c_dkgray);
	draw_set_alpha(0.5);
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
	draw_set_color(c_white);
	draw_set_alpha(1);
}

