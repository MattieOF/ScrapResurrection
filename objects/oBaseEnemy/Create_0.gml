/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

_currentHurtTint = 0;

function die()
{
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
}

