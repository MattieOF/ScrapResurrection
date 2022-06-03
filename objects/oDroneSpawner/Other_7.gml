/// @description Shoot bullet/drone
if (awake && targetInView)
{
	var inst = instance_create_layer(x, y, layer, oDroneSpawnerProjectile);
	inst.direction = image_angle;
	inst.src = id;
	
	// 1/2 chance to spawn a drone as well
	if (random_range(0, 1) < 0.5)
	{
		var droneInst = instance_create_layer(x, y - 32, layer, oDrone);
		droneInst.jump();
	}
}

