var hitsList = ds_list_create();
var hits = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_left, enemyObject, false, true, hitsList, false);

for (var i = 0; i < hits; i++)
{
	if (hits[| i] == undefined) // Not sure why, but sometimes it's undefined
		continue;
	
	if (ds_list_find_index(hitEnemies, hits[| i]) != -1) 
		continue;
	
	show_debug_message(object_get_name(hits[| i].object_index));
	hits[| i].on_hit(new HitInfo(weapon.damage, source));
	
	ds_list_add(hitEnemies, hits[| i]);
}
ds_list_destroy(hitsList);

