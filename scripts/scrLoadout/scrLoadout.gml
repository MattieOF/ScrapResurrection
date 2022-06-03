/// @description Loadout related helper functions
function LoadoutItem(_weapon) constructor
{
	weapon      = _weapon;
	ammoClip    = pointer_null;
	ammoReserve = pointer_null;
	
	if (variable_struct_exists(weapon, "ammoClip"))
		ammoClip    = weapon.ammoClip;
	if (variable_struct_exists(weapon, "ammoReserve"))
		ammoReserve = weapon.ammoReserve;
}

