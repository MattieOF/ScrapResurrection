/// @description Draw radius in debug mode
// Inherit the parent event
event_inherited();

if (global.drawDebugItems)
{
	draw_set_color(c_white);
	draw_set_alpha(0.3);
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
	draw_set_color(c_white);
	draw_set_alpha(1);
}

