/// @description Update things

if (showUseText && useTextAlpha < 1) useTextAlpha += 0.04;
else if (!showUseText && useTextAlpha > 0) useTextAlpha -= 0.04;

healthbarAlpha = approach(healthbarAlpha, healthbarAlphaGoal, 0.03);

var currentChar = oGameManager.current_character();
if (currentChar == undefined) exit;

if (currentChar.hp != prevHp || currentChar.armor != prevArmor)
{
	healthbarAlpha = 1;
	healthbarAlphaGoal = 1;
	alarm[0] = healthbarShowTime * room_speed;
}

var wpn = currentChar.current_weapon();
if (wpn != undefined)
{
	if (!variable_struct_exists(wpn, "ammoClip"))
		weaponText = undefined;
	else
	{
		weaponText = scribble(format_string("[fa_center][fa_middle][sAmmoIcon] [c_{0}]{1}/{2}", wpn.ammoClip == 0 ? "red" : "white", wpn.ammoClip, wpn.ammoReserve));
		if (wpn.ammoClip == 0)
		{
			healthbarAlpha = 1;
			healthbarAlphaGoal = 1;
			alarm[0] = healthbarShowTime * room_speed;
		}
	}
}

if (ammoTextScale > 1)
	ammoTextScale -= 0.02;

prevHp = currentChar.hp;
prevArmor = currentChar.armor;

