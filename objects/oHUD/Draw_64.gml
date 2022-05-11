/// @description Draw HUD

if (useTextAlpha > 0)
{
	useText.blend(c_white, useTextAlpha);
	useText.draw(global.displayWidth / 2, global.displayHeight / 2 + 200);
}

var targetX = global.displayWidth - 5;
var _y = global.displayHeight - 10;
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

if (!instance_exists(oGameManager)) exit;

var currentChar = oGameManager.current_character();
if (currentChar == undefined) exit;

// Health/armor bars
var scale = 4;
var offsetPixels = 7;
var width = sprite_get_width(sHealthbarFill);
var height = sprite_get_height(sHealthbarFill);
var remainder = width - offsetPixels;

// Draw HP bar
var hp = currentChar.hp / currentChar.baseHealth;
var _x = global.displayWidth / 2;
var _y = global.displayHeight - 150;
draw_sprite_ext(sHealthbarFrame, 0, _x, _y, scale, scale, 0, c_white, 1);
draw_sprite_part_ext(sHealthbarFill, 0, 0, 0, offsetPixels + (hp * remainder), height, _x - ((width / 2) * scale), _y - ((height / 2) * scale) + 2, scale, scale, c_white, 1);

// Draw Armor bar
var armor = currentChar.armor / currentChar.maxArmor;
_y = global.displayHeight - 200;
var col = armor <= 0 ? c_dkgray : c_white;
draw_sprite_ext(sArmorbarFrame, 0, _x, _y, scale, scale, 0, col, 1);
draw_sprite_part_ext(sArmorbarFill, 0, 0, 0, offsetPixels + (armor * remainder), height, _x - ((width / 2) * scale), _y - ((height / 2) * scale) + 2, scale, scale, c_white, 1);

