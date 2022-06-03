/// @description Define functions, set up values

// Inherit the parent event
event_inherited();

function use(player)
{
	if (!powerButton.hasPower)
	{
		audio_play_sound(sndFailure, 0, false);
		add_pickup_notif(0, "[c_red]No power", true, sCross);
		return;
	}
	
	audio_play_sound(sndLeverPull, 0, false);
	var inst = instance_create_layer(gunPosition.x, gunPosition.y, layer, oBigGunProjectile);
	inst.direction = point_direction(gunPosition.x, gunPosition.y, oBlockage.x, oBlockage.y);
	inst.image_angle = inst.direction;
	
	sprite.image_index = 1;
	active = false;
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

