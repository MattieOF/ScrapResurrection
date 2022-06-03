/// @description Fade, and check for fade finish
currentFade = approach(currentFade, fadeGoal, fadeSpeed);

if (currentFade == fadeGoal && fading)
{
	if (onFinishFunc != undefined)
	{
		onFinishFunc();
		if (resetFuncOnFinish)
			onFinishFunc = undefined;
	}
	fading = false;
}

