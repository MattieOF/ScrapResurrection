/// @description Draw text
if (!active) exit;

var width  = global.displayWidth;
var height = global.displayHeight;

text.blend(c_white, alpha);
text.draw((width / 2), height / 3);
if (showSkip)
{
	quitText.blend(c_white, skipAlpha);
	quitText.draw(10, global.displayHeight - 10);
}

