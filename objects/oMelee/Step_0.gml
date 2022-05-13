var hitsList = ds_list_create();
var hits = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, enemyObject, false, true, hitsList, false);

for (var i = 0; i < hits; i++)
{
	if (ds_list_find_index(hitEnemies, hitsList[| i]) != -1) 
		continue;
	
	hitsList[| i].on_hit(new HitInfo(weapon.damage, source));
	
	ds_list_add(hitEnemies, hitsList[| i]);
}
ds_list_destroy(hitsList);

