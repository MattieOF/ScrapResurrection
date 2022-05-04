/// @description Init some values

enum playerState
{
	normal,
	shootingHook,
	grappling
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

state = playerState.normal;

function is_grounded()
{
	return place_meeting(x, y + 1, oWall);
}

alarm[0] = 1;

