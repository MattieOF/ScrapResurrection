/// @description Override functions

event_inherited();

function die()
{
	create_debris(sDroneSpawnerDebris, x, y, new Bound(3, 5), new Bound(3, 5), new Bound(50, 60), new Bound(15, 165),,,new Bound(3, 5));
	instance_destroy(id);
}

