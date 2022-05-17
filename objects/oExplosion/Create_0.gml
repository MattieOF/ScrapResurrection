/// @description Init values and functions

radius = 0;
damage = 0;

animTime *= room_speed;
_currentAnimTime = animTime;

function deal_damage()
{
	var hitsList = ds_list_create();
	var hits = collision_circle_list(x, y, radius, ememyObj, false, true, hitsList, false);
	
	for (var i = 0; i < hits; i++)
		hitsList[| i].on_hit(new HitInfo(damage, src));
}

function init(r, dmg, _enemyObj = oHittable, _src = undefined)
{
	radius = r;
	damage = dmg;
	ememyObj = _enemyObj;
	
	// If source is undefined (default value), just use this object, else, use the provided src
	src = (_src == undefined ? id : _src);
	
	create_debris(sExplosion, x, y, new Bound(2, 3), new Bound(2, 3), new Bound(60, 80), new Bound(0, 360),
		new Bound(5, 15),,new Bound(2, 2.5));
	
	deal_damage();
}

