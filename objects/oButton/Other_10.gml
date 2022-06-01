/// @description Setup draw positions
/// This should be called every time the button is repositioned

var halfWidth = width / 2;
var halfHeight = height / 2;

switch (halign)
{
	case fa_left:
		drawX1 = x;
		drawX2 = x + width;
		textX = x + halfWidth;
		break;
	case fa_center:
		drawX1 = x - halfWidth;
		drawX2 = x + halfWidth;
		textX = x;
		break;
	case fa_right:
		drawX1 = x - width;
		drawX2 = x;
		textX = x - halfWidth;
		break;
}

switch (valign)
{
	case fa_top:
		drawY1 = y;
		drawY2 = y + height;
		textY = y + halfHeight;
		break;
	case fa_center:
		drawY1 = y - halfHeight;
		drawY2 = y + halfHeight;
		textY = y;
		break;
	case fa_bottom:
		drawY1 = y - height;
		drawY2 = y;
		textY = y - halfHeight;
		break;
}
