/// @description Check for cam zones

if (active)
{
	var col = instance_place(x, y, oCamZone);
	if (col != noone)
	{
		if (instance_exists(oCamera))
		{
			oCamera.width   = col.widthMultiplier  * 960;
			oCamera.height  = col.heightMultiplier * 540;
			oCamera.xOffset = col.xOffset;
			oCamera.yOffset = col.yOffset;
			oCamera.angle   = col.angle;
			
			if (!global.speedChangeBlocked)
			{
				oCamera.cameraMoveFractionPerFrame   = col.camMoveFraction;
				oCamera.cameraAdjustFractionPerFrame = col.camAdjustFraction;	
			}
		}
	}
}

// Do this again in 15 frames
alarm[0] = 15;

