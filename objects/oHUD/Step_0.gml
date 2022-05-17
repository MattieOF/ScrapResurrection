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

prevHp = currentChar.hp;
prevArmor = currentChar.armor;

