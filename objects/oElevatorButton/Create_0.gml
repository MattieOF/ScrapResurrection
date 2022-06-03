/// @description Define functions, set up values

// Inherit the parent event
event_inherited();

function use(player)
{
	if (elevator.playerCollisionCheck.playerCount < requiredPlayers)
	{
		audio_play_sound(sndFailure, 0, false);
		add_pickup_notif(0, "[c_red]Both players need to be in the elevator", true, sCross, 2);
		return;
	}
	
	sprite.image_index = 1;
	active = false;
	audio_play_sound(sndElevatorButton, 0, false);
	elevator.sound = audio_play_sound(sndElevatorLoop, 0, true);
	elevator.moving = true;
}

// Initialise sprite based on range
sprite = create_sprite(sprite_index, x, y,,,image_xscale, image_yscale);

// Switch to hitbox sprite
sprite_index = hitboxSprite;
var width  = sprite_get_width(hitboxSprite);
var height = sprite_get_height(hitboxSprite);
var scaleX = rangeWidth  / width;
var scaleY = rangeHeight / height;

image_xscale = scaleX;
image_yscale = scaleY;

