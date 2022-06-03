/// @description Initialise sprite

// Inherit the parent event
event_inherited();

sprite = create_sprite(sprite_index, x, y, layer, 1, image_xscale, image_yscale);
visible = false;

state = conscriptState.asleep;

targetGunDistance = 0;

