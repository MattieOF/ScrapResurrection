if (room == rmInit) exit;

paused = false;
pauseSurf = undefined;
radius = 0;
xs = shader_get_uniform(shBlur, "xs");
ys = shader_get_uniform(shBlur, "ys");
r = shader_get_uniform(shBlur, "r");

function pause()
{
	with (oPauseScreen)
	{
		radius = 1;
		paused = true;
	
		// Create pause surf
		if (pauseSurf != undefined && surface_exists(pauseSurf)) surface_free(pauseSurf);
		pauseSurf = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
		surface_copy(pauseSurf, 0, 0, application_surface);
	
		// Show cursor
		window_set_cursor(cr_default);
	
		// (De)activate objects
		instance_deactivate_all(true);
		instance_activate_layer("PauseMenu");
	}
}

function unpause()
{
	with (oPauseScreen)
	{
		paused = false;
	
		// Free pause surf
		if (pauseSurf != undefined && surface_exists(pauseSurf)) surface_free(pauseSurf);
	
		// Hide cursor
		window_set_cursor(cr_none);
	
		// (De)activate objects
		instance_activate_all();
		instance_deactivate_layer("PauseMenu");
	}
}

start_stack("PauseMenu", 100, 100, 10, stackDir.vertical, false);
add_to_stack(create_label(0, 0, "GAME PAUSED.",, c_white, fntUiMainMassive, fa_top, fa_left, 1, 1, false));
add_stack_spacing(100);
add_to_stack(create_button(0, 0, 200, 50, "Resume", unpause, id,,,,,fa_top, fa_left, 1, 1, false));
end_stack();
instance_deactivate_layer("PauseMenu");

