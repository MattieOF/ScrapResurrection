/// @description Define functions, set up values

// Inherit the parent event
event_inherited();

hasPower = false;

function use(player)
{
	sprite.image_speed = 1;
	sprite.image_index = 1;
	active = false;
	hasPower = true;
}

// Initialise sprite based on range
sprite = create_sprite(sprite_index, x, y,,,image_xscale, image_yscale);
sprite.image_speed = 0;

// Switch to hitbox sprite
sprite_index = hitboxSprite;
var width  = sprite_get_width(hitboxSprite);
var height = sprite_get_height(hitboxSprite);
var scaleX = rangeWidth  / width;
var scaleY = rangeHeight / height;

image_xscale = scaleX;
image_yscale = scaleY;

