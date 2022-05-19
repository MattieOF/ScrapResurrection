/// @description Check for collisions
ds_list_clear(playersInside);
playerCount = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, oBasePlayer, 
	false, true, playersInside, false);

