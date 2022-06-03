/// @description Special code to also start level transition
function use(player)
{
	player.add_weapon(weapon);
	add_pickup_notif(0, weapon.name, true, weapon.sprite);
	oLevel1Transition.start();
	instance_destroy(id);
}

