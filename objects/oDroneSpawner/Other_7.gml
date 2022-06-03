/// @description Shoot bullet/drone
if (awake && targetInView)
{
	var inst = instance_create_layer(x, y, layer, oDroneSpawnerProjectile);
	inst.direction = sign(image_xscale) == 1 ? 0 : 180;
	inst.src = id;
	
	// 1/2 chance to spawn a drone as well
	if (random_range(0, 1) < 0.5)
	{
		var droneInst = instance_create_layer(x, y - 36, layer, oDrone);
		droneInst.jump();
	}
}

