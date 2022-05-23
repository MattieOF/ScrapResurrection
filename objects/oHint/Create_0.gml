/// @description Define vars

// 0 = inactive
// 1 = open box
// 2 = display
// 3 = fade out
state = 0;

function set_text(_text)
{
	text = _text;
	boxWidth  = text.get_width() + 25;
	boxHeight = text.get_height() + 25;
}

function add_required_control(ctrl)
{
	array_push(control_requirements, ctrl);
	controlLength++;
}

function draw_box()
{
	var hdw = global.displayWidth  / 2;
	var qdh = global.displayHeight / 4;
	var bW = (boxWidth * boxPercent) / 2;
	var prog = progress / controlLength;
	draw_set_alpha(min(alpha, 0.5));
	draw_set_color(c_green);
	draw_rectangle(hdw - bW, qdh - (boxHeight / 2), (hdw - bW) + (bW * 2 * prog), qdh + (boxHeight / 2), false);
	draw_set_color(c_dkgrey);
	draw_rectangle((hdw - bW) + (bW * 2 * prog), qdh - (boxHeight / 2), (hdw + bW), qdh + (boxHeight / 2), false);
	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_rectangle(hdw - bW, qdh - (boxHeight / 2), hdw + bW, qdh + (boxHeight / 2), true);
}

text = undefined;
boxWidth = 0;
boxHeight = 0;
alpha = 1;
progress = 0;
controlLength = 0;
control_requirements = array_create(0);

boxPercent = 0;

