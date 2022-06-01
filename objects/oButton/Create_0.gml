function draw()
{
	var values = new DrawValues();

	draw_set_color(color);
	draw_set_alpha(alpha);
	draw_set_font(font);
	draw_roundrect(drawX1, drawY1, drawX2, drawY2, false);
	if (selected) 
	{
		draw_set_color(outlineColor);
		draw_roundrect_color(drawX1, drawY1, drawX2, drawY2, c_red, c_red, true);
	}
	draw_set_valign(fa_center);
	draw_set_halign(fa_center);
	draw_text_ext_transformed_color(textX, textY + 2, text, 20, width, textScale, 
		textScale, 0, textColor, textColor, textColor, textColor, alpha);

	draw_set_values(values);
	delete values;
}

color = normalColor;
selected = true;
callAs = id;
if (font == noone) font = fntUiMain;
event_user(0);
