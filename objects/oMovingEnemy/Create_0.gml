/// @description Init values and functions
// Inherit the parent event
event_inherited();

vsp = 0;
hsp = 0;

function is_grounded()
{
	return place_meeting(x, y + 1, oWall);
}

function is_grounded_in_x(xOffset)
{
	return place_meeting(x + xOffset, y + 1, oWall);
}

function jump()
{
	vsp = -jumpHeight;
}

