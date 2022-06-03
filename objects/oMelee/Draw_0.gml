/// @description Draw hitbox in debug mode
if (global.drawDebugItems)
{
	draw_set_color(c_purple);
	draw_set_alpha(1);
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
	draw_set_color(c_white);
}

