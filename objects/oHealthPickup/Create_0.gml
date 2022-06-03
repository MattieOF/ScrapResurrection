/// @description Define onPickup
// Inherit the parent event
event_inherited();

function onPickup(player)
{
	if (player.hp >= player.baseHealth)
		return false;
	
	var prevHp = player.hp;
	player.hp = min(player.hp + healthValue, player.baseHealth);
	addedHealth = player.hp - prevHp;
	instance_destroy(id);
	audio_play_sound(sndHealthPickup, 0, false);
	return true;
}
onPickupFunc = onPickup;

pickupNotifFunc = function()
{
	add_pickup_notif(addedHealth, "health", true);
}

