/// @description Setup object

event_inherited();

function onPickup(player)
{
	// This function should be overwridden by the child object
	show_debug_message("Base onPickup() called, this shouldn't happen.");
}

function use(player)
{
	onPickupFunc(player);
}

active = requireKeyPress;
onPickupFunc = onPickup;
highlighted = false;

// Initialise size of sprite based on range
sprite = create_sprite(sprite_index, x, y,,,image_xscale, image_yscale);

// Switch to hitbox sprite
sprite_index = hitboxSprite;
var width  = sprite_get_width(hitboxSprite);
var height = sprite_get_height(hitboxSprite);
var scaleX = rangeWidth  / width;
var scaleY = rangeHeight / height;
visible = false;

image_xscale = scaleX;
image_yscale = scaleY;

