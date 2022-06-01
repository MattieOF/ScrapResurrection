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
	window_set_cursor(cr_default);
	var inst = instance_create_layer(0, 0, layer, oGameEndScreen);
	inst.init(oGameManager.killScore, oGameManager.time / room_speed, c_white);
	instance_destroy(id);
}

