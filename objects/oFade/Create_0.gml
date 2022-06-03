/// @description Declare variables and functions
currentFade = 0;
onFinishFunc = undefined;
fading = false;

function fade_in(time = 1.5)
{
	currentFade = 1;
	fadeGoal = 0;
	fadeSpeed = 1 / (time * room_speed);
}

function fade_out(time = 1.5)
{
	currentFade = 0;
	fadeGoal = 1;
	fadeSpeed = 1 / (time * room_speed);
}

