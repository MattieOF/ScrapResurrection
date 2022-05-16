/// @description Explode on frame

// Inherit the parent event
event_inherited();

if (image_index == explosionSpriteFrame)
{
	var col = collision_circle(x, y, explosionRadius, oBasePlayer, true, false);
	if (col != noone)
		col.on_hit(new HitInfo(40, id));
}

