/// @description Check for cam zones

var col = instance_place(x, y, oCamZone);
if (col != noone)
{
	if (instance_exists(oCamera))
	{
		oCamera.width   = col.widthMultiplier  * 960;
		oCamera.height  = col.heightMultiplier * 540;
		oCamera.xOffset = col.xOffset;
		oCamera.yOffset = col.yOffset;
	}
}

alarm[0] = 15;

