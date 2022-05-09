/// @description Insert description here
for (var i = 0; i < array_length(debris); i++)
{
	draw_sprite_part_ext(sprite_index, 0, 0, 0, 4, 4, debris[i].X - 2, debris[i].Y - 2, 1, 1, color_lerp(c_black, c_white, debris[i].lifetime / debris[i].maxLifetime), 1);
}

