/// @description Define onPickup
// Inherit the parent event
event_inherited();

function onPickup(player)
{
	if (player.hp >= player.baseHealth)
		return;
	
	player.hp = min(player.hp + healthValue, player.baseHealth);
	instance_destroy(id);
}
onPickupFunc = onPickup;

