/// @description Define state

currentPlayer = undefined;
showUseText = false;
useText = undefined;
useTextAlpha = 0;
pickupNotifs = array_create();

function update_use_text(verb = "use", controlId = controls.use, show = true)
{
	showUseText = show;
	
	var control = get_control(controlId);
	var controlString = "";
	
	switch (control.type)
	{
		case controlType.key:
			controlString = key_string(control.value);
			break;
		case controlType.mouse:
			controlString = mouse_button_string(control.value);
			break;
		case controlType.mousewheel:
			controlString = mouse_wheel_string(control.value);
			break;
	}
	
	useText = scribble(format_string("[pulse][fntUiMain][c_white][fa_center][fa_middle]Press [c_yellow][[{0}] [c_white]to {1}", controlString, string_lower(verb)));
}
