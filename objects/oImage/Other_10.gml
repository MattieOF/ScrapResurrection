/// @description Refresh values

if (sprite == noone) return;
if (!sprite_exists(sprite)) 
{
	log_format_string("Invalid sprite on oImage {0}", id);
	return;
}
width = sprite_get_width(sprite);
height = sprite_get_height(sprite);
