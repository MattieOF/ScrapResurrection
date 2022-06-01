function draw()
{
	var values = new DrawValues();

	draw_set_color(color);
	draw_set_alpha(alpha);
	draw_set_font(font);
	draw_set_valign(valign);
	draw_set_halign(halign);
	draw_text_ext_transformed_color(x, y, text, 20, width, scale, 
		scale, 0, color, color, color, color, alpha);

	draw_set_values(values);
	delete values;
}

width = 0;
height = 0;
