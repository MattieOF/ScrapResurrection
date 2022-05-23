/// @description Tick values

switch (state)
{
	case 1:
		boxPercent += 0.05;
		if (boxPercent >= 1)
			state++;
		break;
	case 2:
		for (var i = 0; i < array_length(control_requirements); i++)
		{
			if (control_check(control_requirements[i]))
			{
				progress++;
				array_delete(control_requirements, i, 1);
				if (i != array_length(control_requirements))
					i--;
			}
		}
		
		if (progress = controlLength)
			state++;
		
		break;
	case 3:
		alpha -= 0.05;
		if (alpha <= 0)
			instance_destroy(id);
		break;
}

