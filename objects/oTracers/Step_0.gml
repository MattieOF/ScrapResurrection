/// @description Update all tracers

for (var i = 0; i < array_length(global.tracers); i++)
{
	global.tracers[i].update();
	if (global.tracers[i].time <= 0)
	{
		array_delete(global.tracers, i, 1);
		if (i != array_length(global.tracers))
			i--;
	}
}

