/// @description Explode on frame

// Inherit the parent event
event_inherited();

if (image_index == explosionSpriteFrame)
{
	drawExplosion = true;
	var col = collision_circle(x, y, explosionRadius, oBasePlayer, true, false);
	if (col != noone)
		col.on_hit(new HitInfo(40, id));
}

if (drawExplosion)
	drawExplosionRadius = approach(drawExplosionRadius, explosionRadius, explosionRadius / 20);

add_debug_text(format_string("Draw explosion: {0}, draw explosion radius {1}", drawExplosion, drawExplosionRadius))

