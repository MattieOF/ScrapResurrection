/// @description Declare variables, initialise size
function init(width, height, wpn, src)
{
	var sw = sprite_get_width(sprite_index);
	var sh = sprite_get_height(sprite_index);
	image_xscale = width  / sw;
	image_yscale = height / sh;
	weapon = wpn;
	source = src;
}

hitEnemies = ds_list_create();

