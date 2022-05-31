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

if (prevChar != currentChar)
{
	dashUIs = array_create(currentChar.maxDashCharges);
}
else if (prevCurrentCharge != currentChar.dashCharges
         && prevCurrentCharge != currentChar.maxDashCharges)
{
	dashUIs[prevCurrentCharge] = 5;
	healthbarAlpha = 1;
	healthbarAlphaGoal = 1;
	alarm[0] = healthbarShowTime * room_speed;
}

prevChar = currentChar;
prevCurrentCharge = currentChar.dashCharges;

// Health/armor bars
var scale = 4;
var offsetPixels = 7;
var width = sprite_get_width(sHealthbarFill);
var height = sprite_get_height(sHealthbarFill);
var remainder = width - offsetPixels;

// Draw HP bar
var alpha = lerp(minHealthbarAlpha, 1, healthbarAlpha);
var hp = currentChar.hp / currentChar.baseHealth;
var _x = global.displayWidth / 2;
var _y = global.displayHeight - 160;
draw_sprite_ext(sHealthbarFrame, 0, _x, _y, scale, scale, 0, c_white, alpha);
draw_sprite_part_ext(sHealthbarFill, 0, 0, 0, offsetPixels + (hp * remainder), height, _x - ((width / 2) * scale), _y - ((height / 2) * scale) + 2, scale, scale, c_white, alpha);

// Draw Armor bar
var armor = currentChar.armor / currentChar.maxArmor;
_y = global.displayHeight - 120;
var col = armor <= 0 ? c_dkgray : c_white;
draw_sprite_ext(sArmorbarFrame, 0, _x, _y, scale, scale, 0, col, alpha);
draw_sprite_part_ext(sArmorbarFill, 0, 0, 0, offsetPixels + (armor * remainder), height, _x - ((width / 2) * scale), _y - ((height / 2) * scale) + 2, scale, scale, c_white, alpha);

// Draw dash
draw_set_alpha(alpha);
_y = global.displayHeight - 90;
scale = 0.5;
var fullWidth = width * 4;
_x -= (fullWidth / 2);
draw_sprite_ext(sDashIcon, 0, _x, _y, scale, scale, 0, c_white, alpha);
_x += (sprite_get_width(sDashIcon) * scale) + 5;
fullWidth -= (sprite_get_width(sDashIcon) * scale) + 5;
_y += 6;

var dashUiLength = (fullWidth - (max(((array_length(dashUIs) - 1) * 5), 0))) / array_length(dashUIs);

for (var i = 0; i < array_length(dashUIs); i++)
{
	draw_set_color(c_dkgray);
	draw_rectangle(_x, _y, _x + dashUiLength, _y + 10, false);
	
	var dashOffset = dashUIs[i];
	var currentCharge = currentChar.dashCharges;
	var chargePercent = 1 - (currentChar._currentDashTime / (currentChar.dashRecharge * room_speed));
	draw_set_color(color_lerp(c_white, c_green, dashOffset / 5));
	if (dashOffset > 0)
		dashUIs[i] -= 0.25;
	if (i == currentCharge)
		draw_rectangle(_x - dashOffset, _y - dashOffset, _x + (dashUiLength * chargePercent) + dashOffset, _y + 10 + dashOffset, false);
	else if (i < currentCharge)
		draw_rectangle(_x - dashOffset, _y - dashOffset, _x + dashUiLength + dashOffset, _y + 10 + dashOffset, false);
	_x += dashUiLength + 5;
}

// Ammo
if (weaponText != undefined)
{
	weaponText.blend(c_white, alpha);
	weaponText.transform(ammoTextScale, ammoTextScale, 0);
	weaponText.draw(global.displayWidth / 2, global.displayHeight - 45);
}

draw_set_alpha(1);

