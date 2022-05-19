/// @description Move elevator

if (!moving) exit;

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
}

if (xDelta == 0 && yDelta == 0)
{
	moving = false;
	if (egg != noone)
	{
		if (egg.playerCount > 0)
			spawnZone_elevatorEgg.spawn = true;
	}
}

