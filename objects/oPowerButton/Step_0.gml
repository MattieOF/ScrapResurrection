/// @description Check for layers

if (sprite.layer == global.highlightedUsablesLayer && (!highlighted || !active))
	sprite.layer = global.usablesLayer;
	
sprite.x = x;
sprite.y = y;

show_debug_message(sprite.image_index);
show_debug_message(hasPower);
if (sprite.image_index < 1 && hasPower)
{
	hasPower = false;
	active = true;
	lvl2_sparks.active = false;
	lvl2_sparks_deathZone.active = false;
	sprite.image_speed = 0;
	sprite.image_index = 0;
}
	
if (!active) return;

highlighted = false;

