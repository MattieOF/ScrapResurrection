/// @description Update debris, remove dead ones

for (var i = 0; i < array_length(debris); i++)
{
	debris[i].update();
	if (debris[i].lifetime <= 0)
	{
		array_delete(debris, i, 1);
		if (i != array_length(debris))
			i--;
	}
}

if (shouldDieWhenNoElements && array_length(debris) == 0)
	instance_destroy(id);

