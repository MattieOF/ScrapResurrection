/// @description Draw HUD

if (useTextAlpha > 0)
{
	useText.blend(c_white, useTextAlpha);
	useText.draw(global.displayWidth / 2, global.displayHeight / 2 + 200);
}

var targetX = global.displayWidth - 5;
var _y = global.displayHeight - 5;
for (var i = 0; i < array_length(pickupNotifs); i++)
{
	pickupNotifs[i].text.draw(pickupNotifs[i].x, _y);
	_y -= pickupNotifs[i].height + 5;
	
	if (pickupNotifs[i].time > 0)
	{
		if (pickupNotifs[i].x > targetX)
			pickupNotifs[i].x -= 20;
		else 
			pickupNotifs[i].time--;
	}
	else if (pickupNotifs[i].x < targetX + pickupNotifs[i].width)
		pickupNotifs[i].x += 20;
	else
		array_delete(pickupNotifs, i, 1);
}

