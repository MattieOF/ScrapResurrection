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

state = playerState.normal;

function is_grounded()
{
	return place_meeting(x, y + 1, oWall);
}

function hurt(dmg)
{
	hp -= dmg;
}

alarm[0] = 1;

