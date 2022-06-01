/// @description Check for plates being pressed

currentPressed = 0;

for (var i = 0; i < array_length(plates); i++)
{
	if (plates[i].pressed)
		currentPressed++;
}

if (currentPressed == array_length(plates))
{
	oFade.fade_out();
	instance_destroy(id);
}

