/// @description Define draw function and values
function draw()
{
	var values = new DrawValues();

	draw_set_color(color);
	draw_set_alpha(alpha);
	draw_set_font(font);
	draw_set_valign(fa_center);
	draw_set_halign(fa_left);
	draw_text_ext_transformed_color(x - width / 2, y, text, 20, width, scale, 
		scale, 0, color, color, color, color, alpha);
	draw_set_color(checkboxColor);
	draw_rectangle(x + width / 2 - height, y - (height / 2), x + width / 2, y + (height / 2), false);

	if (checked)
	{
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		draw_sprite_stretched(sCheckmark, 0, x + width / 2 - height, y - (height / 2), height, height);
	}

	draw_set_values(values);
	delete values;
}

checked = false;
padding = 15;
onToggle = undefined; // Should be a function with 1 bool parameter
width = 0;
height = 0;
checkboxColor = normalCheckboxColor;
halign = fa_center;
valign = fa_center;
