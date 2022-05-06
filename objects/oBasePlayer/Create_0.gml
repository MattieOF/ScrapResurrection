/// @description Init some values

enum playerState
{
	normal,
	shootingHook,
	missedHook,
	grappling
}

function state_string()
{
	switch (state)
	{
		case playerState.normal:
			return "Normal";
		case playerState.shootingHook:
			return "Shooting Hook";
		case playerState.missedHook:
			return "Missed Hook";
		case playerState.grappling:
			return "Grappling";
	}
}

active = false;
hsp = 0;
vsp = 0;
canJump = jumpFrames;
dsp = 0;
_currentDashTime = 0;
maxDashCharges = dashCharges;
floating = false;
_currentExtraJumps = extraJumps;
_currentHookLen = 0;
_hookDir = 0;
_gX = 0;
_gY = 0;
hp = baseHealth;
armor = 0;

state = playerState.normal;

function is_grounded()
{
	return place_meeting(x, y + 1, oWall);
}

function hurt(dmg)
{
	if (armor > 0)
	{
		// We have armor, take it from that first
		if (armor < dmg)
		{
			// We don't have enough armor to absorb all the damage, so:
			// 1. Take what we can from the armor
			// 2. Ensure the armor is now zero
			dmg -= armor;
			armor = 0;
		}
		else
		{
			// Our armor can fully absorb the damage
			// Take the dmg from the armor, and return from the function
			armor -= dmg;
			return;
		}
	}
	
	// If there is still dmg to take after the armor, then subtract it from HP
	hp -= dmg;
}

function add_armor(amount)
{
	armor += amount;
	if (armor > maxArmor)
		armor = maxArmor;
}

alarm[0] = 1;

