/// @description Move elevator

if (!moving) 
{
	if (sound != noone) audio_stop_sound(sound);
	exit;
}

var oldX = x;
var oldY = y;
y = approach(y, endPos.y, elevatorSpeed);
x = approach(x, endPos.x, elevatorSpeed);
var xDelta = x - oldX;
var yDelta = y - oldY;

for (var i = 0; i < ds_list_size(relatedCollision); i++)
{
	var current = relatedCollision[| i];
	current.x += xDelta;
	current.y += yDelta;
}

for (var i = 0; i < playerCollisionCheck.playerCount; i++)
{
	var current = playerCollisionCheck.playersInside[| i];
	current.x += xDelta;
	current.y += yDelta;
	
	// Also change player sprite position so it doesn't look like it's floating
	current.sprite.x += xDelta;
	current.sprite.y += yDelta;
}

if (xDelta == 0 && yDelta == 0)
{
	audio_play_sound(sndElevatorLand, 0, false);
	moving = false;
	if (egg != noone)
	{
		if (egg.playerCount > 0)
			spawnZone_elevatorEgg.spawn = true;
	}
}

