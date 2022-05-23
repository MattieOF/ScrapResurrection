randomize();
global.flynnHook = false;

/// @desc Destroys the provided target if the number of the provided object is over the provided threshold
/// @param {object} objectIndex - Type of object to look for the number of. If undefined, it's set to object_index.
/// @param {int} threshold - If amount of instances of objectIndex is over this value, destroy the target. 1 by default.
/// @param {instance} target - Object to be destroyed if criteria is met. If undefined, it's set to id.
function destroy_if_instance_exists(objectIndex = undefined, threshold = 1, target = undefined)
{
	if (objectIndex == undefined) objectIndex = object_index;
	if (target == undefined) target = id;
	if (instance_number(id) > threshold) instance_destroy(target);
}

function approach(value, target, amount)
{
	return value + clamp(target - value, -amount, amount);
}

function approach_angle(value, target, amount, maximum = 360)
{
	var diff = target - value;
	if (abs(diff) >= 350) return target;
	return value + clamp(target - value, -amount, amount);
}

function angle_reverse(_angle)
{
	return (_angle + 180) % 360;
}

function Point(_x, _y) constructor
{
	X = _x;
	Y = _y;
}

function point_on_line(x1, y1, x2, y2, t)
{
	var dir = point_direction(x1, y1, x2, y2);
	var dist = point_distance(x1, y1, x2, y2);
	var outX = x1 + lengthdir_x(dist * t, dir);
	var outY = y1 + lengthdir_y(dist * t, dir);
	
	return new Point(outX, outY);
}

function deactivate_game_layers()
{
	var a = layer_get_all();
	for (var i = 0; i < array_length(a); i++;)
	{
		var name = layer_get_name(a[i]);
		if (name == "Instances" || name == "Background") continue;
		instance_deactivate_layer(a[i]);
	}
}

function activate_game_layers()
{
	var a = layer_get_all();
	for (var i = 0; i < array_length(a); i++;)
	{
		var name = layer_get_name(a[i]);
		if (name == "PauseMenu" || name == "LoadCheckpoint" || name == "Exit" || name == "SelectionUI" || name == "UseUI" || name == "CloseUI")
			continue;
		instance_activate_layer(a[i]);
	}
}

function play_sound_if_exists(_sound, _priority = 0, _loops = false)
{
	if (_sound == undefined || _sound == noone || _sound == pointer_null)
		return;
	audio_play_sound(_sound, _priority, _loops);
}

function color_lerp(a, b, amount)
{
	var _ar = color_get_red(a);
	var _ag = color_get_green(a);
	var _ab = color_get_blue(a);
	
	var _br = color_get_red(b);
	var _bg = color_get_green(b);
	var _bb = color_get_blue(b);
	
	return make_color_rgb(lerp(_ar, _br, amount), lerp(_ag, _bg, amount), lerp(_ab, _bb, amount));
}

function color_lerp_rgb(ar, ag, ab, br, bg, bb, amount)
{
	return make_color_rgb(lerp(ar, br, amount), lerp(ag, bg, amount), lerp(ab, bb, amount));
}

function color_invert(colour)
{
	var _r = color_get_red(colour);
	var _g = color_get_green(colour);
	var _b = color_get_blue(colour);
	
	return make_color_rgb(255 - _r, 255 - _g, 255 - _b);
}

function color_invert_rgb(r, g, b)
{
	return make_color_rgb(255 - r, 255 - g, 255 - b);
}

function random_point_in_rect(x1, y1, x2, y2)
{
	var _x = random_range(x1, x2);
	var _y = random_range(y1, y2);
	
	return 
	{
		X : _x,
		Y : _y
	};
}

function random_free_point_in_rect(x1, y1, x2, y2, obj = undefined, tries = 100)
{
	do
	{
		var _x = random_range(x1, x2);
		var _y = random_range(y1, y2);
		tries--;
	} until ((obj != undefined ? !place_meeting(_x, _y, obj) : place_free(_x, _y)) || tries <= 0);
	
	return 
	{
		X : _x,
		Y : _y
	};
}

function create_sprite(_sprite, _x, _y, _layer = undefined, _imagespeed = 1, _imagexscale = 1, _imageyscale = 1)
{
	var obj = instance_create_layer(_x, _y, _layer == undefined ? layer : _layer, oSprite);
	obj.sprite_index = _sprite;
	obj.image_speed = _imagespeed;
	obj.image_xscale = _imagexscale;
	obj.image_yscale = _imageyscale;
	
	return obj;
}

// Code from https://www.reddit.com/r/gamemaker/comments/njbokj/heres_a_script_to_convert_a_key_value_to_a_string/
// Slightly edited by Matt
function key_string(key) 
{
	switch(key)
	{
		case	65:		return "A"       
		case	66:		return "B"       
		case	67:		return "C"       
		case	68:		return "D"       
		case	69:		return "E"       
		case	70:		return "F"       
		case	71:		return "G"       
		case	72:		return "H"       
		case	73:		return "I"       
		case	74:		return "J"       
		case	75:		return "K"       
		case	76:		return "L"       
		case	77:		return "M"       
		case	78:		return "N"       
		case	79:		return "O"       
		case	80:		return "P"       
		case	81:		return "Q"       
		case	82:		return "R"       
		case	83:		return "S"       
		case	84:		return "T"       
		case	85:		return "U"       
		case	86:		return "V"       
		case	87:		return "W"       
		case	88:		return "X"       
		case	89:		return "Y"       
		case	90:		return "Z"       
		case	vk_lcontrol:	return "L CTRL"		 
		case	vk_rcontrol:	return "R CTRL"		 
		case	vk_lalt:	return "L ALT"       
		case	vk_ralt:	return "R ALT"       
		case	186:	return ";"
		case	222:	return "'"
		case	vk_enter:		return "Enter"
		case	220:	return	"\\"
		case	vk_backspace:		return	"Backspace"
		case	219:	return "["
		case	221:	return "]"
		case	188:	return ","
		case	190:	return "."
		case	191:	return "/"
		case	vk_shift:		return "Shift"
		case	vk_tab:		return "Tab"
		case	192:	return "`"
		case	48:		return "0"
		case	49:		return "1"
		case	50:		return "2"
		case	51:		return "3"
		case	52:		return "4"
		case	53:		return "5"
		case	54:		return "6"
		case	55:		return "7"
		case	56:		return "8"
		case	57:		return "9"
		
		case	96:		return "Num 0"
		case	97:		return "Num 1"
		case	98:		return "Num 2"
		case	99:		return "Num 3"
		case	100:	return "Num 4"
		case	101:	return "Num 5"
		case	102:	return "Num 6"
		case	103:	return "Num 7"
		case	104:	return "Num 8"
		case	105:	return "Num 9"
		case	111:	return "Num /"
		case	106:	return "Num *"
		case	107:	return "Num +"
		case	110:	return "Num ."
		case	109:	return "Num -"
		
		case	vk_f1:	return "F1"
		case	vk_f2:	return "F2"
		case	vk_f3:	return "F3"
		case	vk_f4:	return "F4"
		case	vk_f5:	return "F5"
		case	vk_f6:	return "F6"
		case	vk_f7:	return "F7"
		case	vk_f8:	return "F8"
		case	vk_f9:	return "F9"
		case	vk_f10:	return "F10"
		case	vk_f11:	return "F11"
		case	vk_f12:	return "F12"
		case	145:	return "ScrLk"
		case	vk_pause:		return "Pause"
		case	20:		return "Caps Lock"
		case	189:	return "-"
		case	187:	return "="
		case	vk_insert:		return "Insert"
		case	vk_home:		return "Home"
		case	vk_pageup:		return "Page Up"
		case	vk_pagedown:		return "Page Down"
		case	vk_end:		return "End"
		case	vk_delete:		return "Delete"
		case	144:	return "NumLock"
		case	38:		return "Up"
		case	40:		return "Down"
		case	37:		return "Left"
		case	39:		return "Right"
		case	91:		return "L Windows"
		case	92:		return "R Windows"
		case	vk_space:		return "Space"
		case	0:		return " "
		case	179:	return "Play"
		case	173:	return "Mute"
		case	174:	return "Volume Down"
		case	175:	return "Volume Up"
		case    vk_escape: return "Escape";

		default:		return undefined;
	}
}

function mouse_button_string(mb)
{
	switch (mb)
	{
		case mb_left: return "Left Mouse Button";
		case mb_middle: return "Middle Mouse Button";
		case mb_right: return "Right Mouse Button";
		case mb_side1: return "Side Mouse Button 1";
		case mb_side2: return "Side Mouse Button 2";
		default: return undefined;
	}
}

function mouse_wheel_string(mw)
{
	switch (mw)
	{
		case mouseWheelDir.up: return "Mouse Wheel Up";	
		case mouseWheelDir.down: return "Mouse Wheel Down";	
		case mouseWheelDir.none: return "Mouse Wheel None";	
	}
}

function Bound(_min, _max) constructor
{
	minimum = _min;
	maximum = _max;
}

function get_real_inside_bound(bound)
{
	return random_range(bound.minimum, bound.maximum);
}

function get_int_inside_bound(bound)
{
	return irandom_range(bound.minimum, bound.maximum);
}

