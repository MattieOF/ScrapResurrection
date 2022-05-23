/// @description Draw self, and hitbox in debug

draw_self();

if (global.drawDebugItems)
{
	draw_set_color(c_dkgrey);
	draw_set_alpha(0.25);
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
	draw_set_color(c_white);
	draw_set_alpha(1);
}

