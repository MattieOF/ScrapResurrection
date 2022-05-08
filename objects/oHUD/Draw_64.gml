/// @description Draw HUD

if (useTextAlpha > 0)
{
	useText.blend(c_white, useTextAlpha);
	useText.draw(global.displayWidth / 2, global.displayHeight / 2 + 200);
}

