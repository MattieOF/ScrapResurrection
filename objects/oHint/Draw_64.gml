/// @description Draw

switch(state)
{
	case 1:
		draw_box();
		break;
	case 3:
		text.blend(c_white, alpha);
	case 2:
		draw_box();
		var hdw = global.displayWidth  / 2;
		var qdh = global.displayHeight / 4;
		text.draw(hdw, qdh);
		break;
}

