/// @description Insert description here
for (var i = 0; i < array_length(debris); i++)
{
	var scale  = debris[i].scale;
	var width  = debris[i].width  * scale;
	var height = debris[i].height * scale;
	draw_sprite_part_ext(sprite_index, 0, debris[i].tX, debris[i].tY, width, height, debris[i].X - (width / 2), debris[i].Y - (height / 2), scale, scale, color_lerp(c_black, c_white, debris[i].lifetime / debris[i].maxLifetime), 1);
}

