/// @description Define state

shouldDraw = true;
currentPlayer = undefined;
showUseText = false;
useText = undefined;
useTextAlpha = 0;
healthbarAlpha = 1;
healthbarAlphaGoal = 1;
prevHp = 0;
prevArmor = 0;
prevChar = undefined;
prevCurrentCharge = 0;
prevLoadoutSize = 0;
prevWpnIndex = 0;
weaponSelectOpen = false;
weaponSelectText = array_create(0);
_weaponSelectProgress = 0;
weaponText = undefined;
ammoTextScale = 1;
alarm[0] = healthbarShowTime * room_speed;
pickupNotifs = array_create(0);
minHealthbarAlpha = 0.3;

// Dash UI
dashUIs = array_create(0);

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

