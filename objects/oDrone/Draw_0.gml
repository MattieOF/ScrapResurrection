/// @description Draw radius in debug mode
// Inherit the parent event
event_inherited();

if (drawExplosion)
{
	draw_set_color(c_orange);
	draw_set_alpha(0.7);
	draw_circle_ext(x, y, drawExplosionRadius, 20, 0, 360, 5, true);
	draw_set_color(c_white);
	draw_set_alpha(1);
}

if (global.drawDebugItems)
{
	draw_set_color(c_red);
	draw_set_alpha(1);
	draw_circle(x, y, explosionRadius, true);
	draw_set_color(c_white);
}

