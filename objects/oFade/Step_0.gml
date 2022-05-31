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

