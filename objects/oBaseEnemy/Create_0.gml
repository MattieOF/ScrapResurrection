/// @description Init values and functions
// Inherit the parent event
event_inherited();

_currentHurtTint = 0;

target = noone;
targetInView = false;
targetLastX = 0;
targetLastY = 0;
awake = false;
hitSoundFunc = noone;

alarm[0] = 15;

function die()
{
	oGameManager.killScore += value;
	// This function could be used for death effects or animations
	instance_destroy(id);
}

function hurt(dmg)
{
	_currentHurtTint = 1;
	hp -= dmg;
	if (hp <= 0) 
		die();
}

function on_hit(hitInfo)
{
	hurt(hitInfo.damage);
	if (hitSoundFunc != noone)
		hitSoundFunc();
}

