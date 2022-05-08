/// @description Define onPickup
// Inherit the parent event
event_inherited();

function onPickup(player)
{
	if (player.armor >= player.maxArmor)
		return false;
	
	var prevArmor = player.armor;
	player.armor = min(player.armor + armorValue, player.maxArmor);
	addedArmor = player.armor - prevArmor;
	instance_destroy(id);
	return true;
}
onPickupFunc = onPickup;

pickupNotifFunc = function()
{
	add_pickup_notif(addedArmor, "armor", true);
}

