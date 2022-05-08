/// @description Define onPickup
// Inherit the parent event
event_inherited();

function onPickup(player)
{
	if (player.armor >= player.maxArmor)
		return false;
	
	player.armor = min(player.armor + armorValue, player.maxArmor);
	instance_destroy(id);
	return true;
}
onPickupFunc = onPickup;

