/// @description Explode on frame

// Inherit the parent event
event_inherited();

if (image_index == explosionSpriteFrame)
{
	var inst = instance_create_layer(x, y, layer, oExplosion);
	inst.init(explosionRadius, damage, oHittable, id);
}

