// Type definitions

/// @description Enum representing all controls that can be pressed
enum controls
{
	left,
	right,
	jump,
	switchCharacter,
	quit,
	screenshot,
	toggleDebug
}

/// @description Enum representing the types of a control (key, mouse)
enum controlType
{
	key,
	mouse,
	mousewheel
}

enum mouseWheelDir
{
	none,
	up,
	down
}

/// @description Create a control struct, with a control type and a control value
/// @param {controlType} type - Type of the control, should be either key or mouse
/// @param value - Value of the control, should be a keyboard key code or a mousebutton id depending on the type
/// @returns {Control} A struct representing the control
function Control(_type, _value) constructor
{
	type = _type;
	value = _value;
}

control_defaults();

// Load controls from file, if it exists.
// If not, save defaults to file.
load_controls();

// Function defs.

/// @description Reset controls to default
function control_defaults()
{
	// Controls struct def
	global.controls = {};

	// Init default controls
	set_control(controls.left,            new Control(controlType.key,        ord("A")));
	set_control(controls.right,           new Control(controlType.key,        ord("D")));
	set_control(controls.jump,            new Control(controlType.key,        vk_space));
	set_control(controls.switchCharacter, new Control(controlType.key,        ord("C")));
	// set_control(controls.attackPrimary,   new Control(controlType.mouse,      mb_left));
	set_control(controls.quit,            new Control(controlType.key,        vk_escape));
	// set_control(controls.toggleFPS,       new Control(controlType.key,        vk_f1));
	// set_control(controls.toggleDistort,   new Control(controlType.key,        vk_f2));
	set_control(controls.screenshot,      new Control(controlType.key,        vk_f5));
	set_control(controls.toggleDebug,     new Control(controlType.key,        vk_f3));
	// set_control(controls.reload,          new Control(controlType.key,        ord("R")));
	// set_control(controls.weaponNext,      new Control(controlType.mousewheel, mouseWheelDir.up));
	// set_control(controls.weaponPrevious,  new Control(controlType.mousewheel, mouseWheelDir.down));
	// set_control(controls.save,            new Control(controlType.key,        ord("E")));
	// set_control(controls.openInventory,   new Control(controlType.key,        vk_tab));
}

/// @description Save backup of controls file, reset controls to default, and save again.
/// @param {bool} [backup] - If the current controls file should be backed up or not
/// @param {string} [filename] - Filename of the controls file. Include the extension.
function reset_controls(backup = true, filename = "controls.json")
{
	if (backup == true && file_exists(filename))
		file_copy(filename, filename + ".old");
		
	control_defaults();
	save_controls(filename);
}

/// @description Set a control
/// @param {controls} controlId - Control from controls enum to set binding of
/// param {Control} controlValue - Use new Control(type, value) to create a value for this
function set_control(controlId, controlValue)
{
	global.controls[$ controlId] = controlValue;
}

/// @description Get a control struct
/// @param {controls} controlId - ID (from the controls enum) of the control to get the struct for
/// @returns Control struct for the provided control
function get_control(controlId)
{
	return global.controls[$ controlId];
}

/// @description Check if a control is currently down
/// @param {controls} controlId - ID of the control to check
/// @returns {bool} If the control is currently pressed or not
function control_check(controlId)
{
	var control = global.controls[$ controlId];
	if (control == undefined) return false;
	
	switch (control.type)
	{
		case controlType.key:
			return keyboard_check(control.value);
		case controlType.mouse:
			return mouse_check_button(control.value);
		case controlType.mousewheel:
			switch (control.value)
			{
				case mouseWheelDir.up:
					return mouse_wheel_up();
				case mouseWheelDir.down:
					return mouse_wheel_down();
				case mouseWheelDir.none:
					return !mouse_wheel_up() && !mouse_wheel_down();
				default:
					return false;
			}
		default:
			return false;
	}
}

/// @description Check if a control is down this frame
/// @param {controls} controlId - ID of the control to check
/// @returns {bool} If the control was pressed this frame or not
function control_check_pressed(controlId)
{
	var control = global.controls[$ controlId];
	if (control == undefined) return false;
	
	switch (control.type)
	{
		case controlType.key:
			return keyboard_check_pressed(control.value);
		case controlType.mouse:
			return mouse_check_button_pressed(control.value);
		case controlType.mousewheel:
			switch (control.value)
			{
				case mouseWheelDir.up:
					return mouse_wheel_up();
				case mouseWheelDir.down:
					return mouse_wheel_down();
				case mouseWheelDir.none:
					return !mouse_wheel_up() && !mouse_wheel_down();
				default:
					return false;
			}
		default:
			return false;
	}
}

/// @description Check if a control was released this frame
/// @param {controls} controlId - ID of the control to check
/// @returns {bool} If the control was released this frame or not
function control_check_released(controlId)
{
	var control = global.controls[$ controlId];
	if (control == undefined) return false;
	
	switch (control.type)
	{
		case controlType.key:
			return keyboard_check_released(control.value);
		case controlType.mouse:
			return keyboard_check_released(control.value);
		case controlType.mousewheel:
			switch (control.value)
			{
				case mouseWheelDir.up:
					return mouse_wheel_up();
				case mouseWheelDir.down:
					return mouse_wheel_down();
				case mouseWheelDir.none:
					return !mouse_wheel_up() && !mouse_wheel_down();
				default:
					return false;
			}
		default:
			return false;
	}
}

/// @description Load controls from disk using json_parse.
/// @param {string} [filename] - Filename of the controls file. Include the extension. Default is "controls.json".
function load_controls(filename = "controls.json")
{
	if (!file_exists(filename)) 
	{
		save_controls(filename);
		return;
	}
	
	var file = file_text_open_read(filename);
	global.controls = json_parse(file_text_read_string(file));
	file_text_close(file);
}

/// @description Delete the file if it exists, and save the controls to the file using json_stringify
/// @param {string} [filename] - Filename of the controls file. Include the extension. Default is "controls.json".
function save_controls(filename = "controls.json")
{
	if (file_exists(filename)) file_delete(filename);
	
	var file = file_text_open_write(filename);
	file_text_write_string(file, json_stringify(global.controls));
	file_text_close(file);
}

