/// @description Draw radius in debug mode
// Inherit the parent event
event_inherited();

if (global.drawDebugItems)
{
	draw_set_color(c_red);
	draw_set_alpha(1);
	draw_circle(x, y, explosionRadius, true);
	draw_set_color(c_white);
}

