radius = approach(radius, 10, 0.3);

if (paused && surface_exists(pauseSurf))
{
	var width = surface_get_width(pauseSurf);
	var height = surface_get_height(pauseSurf);
	var xscale = width / global.displayWidth;
	var yscale = height / display_get_gui_height();
	shader_set(shBlur);
	shader_set_uniform_f(xs, width);
	shader_set_uniform_f(ys, height);
	shader_set_uniform_f(r, radius);
	draw_surface_ext(pauseSurf, 0, 0, xscale, yscale, 0, c_white, 1);
	shader_reset();
}

