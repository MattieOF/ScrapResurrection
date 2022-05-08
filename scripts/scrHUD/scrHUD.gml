function PickupNotif(_text, _time = 1.5) constructor
{
	text = _text;
	time = _time * room_speed;
	height = text.get_height();
	width = text.get_width();
	x = global.displayWidth + width;
}

function add_pickup_notif(number, name, showIcon = true, time = 1.5)
{
	if (!instance_exists(oHUD)) return;
	
	var iconString = "";
	if (showIcon)
		iconString = format_string("[{0}]", sprite_get_name(sprite.sprite_index));
		
	var text = scribble(format_string("[fa_bottom][fa_right][c_gray]+{0} [c_white]{1} {2}", number, name, iconString));
	array_push(oHUD.pickupNotifs, new PickupNotif(text, time));
}

