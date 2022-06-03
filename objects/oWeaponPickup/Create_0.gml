/// @description Define functions, set up values

// Inherit the parent event
event_inherited();

function use(player)
{
	player.add_weapon(weapon);
	audio_play_sound(sndGunPickup, 0, false);
	add_pickup_notif(0, weapon.name, true, weapon.sprite);
	instance_destroy(id);
}

// Initialise sprite based on range
sprite = create_sprite(weapon.sprite, x, y,,,image_xscale, image_yscale);

// Switch to hitbox sprite
sprite_index = hitboxSprite;
var width  = sprite_get_width(hitboxSprite);
var height = sprite_get_height(hitboxSprite);
var scaleX = rangeWidth  / width;
var scaleY = rangeHeight / height;

image_xscale = scaleX;
image_yscale = scaleY;

