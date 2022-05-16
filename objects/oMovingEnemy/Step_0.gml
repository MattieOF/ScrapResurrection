/// @description Move
// Inherit the parent event
event_inherited();

// Attempt to jump up, and jump gaps
if (awake)
{
	var dir = point_direction(x, y, targetLastX, targetLastY);
	hsp = lengthdir_x(walkSpeed, dir);
	
	if (canJump && is_grounded())
	{
		if (place_meeting(x + (hsp * jumpDistance), y, oWall))
			jump();
		else if (!is_grounded_in_x((hsp * jumpDistance)))
			jump();
	}
}

// Collision code
vsp += grv;

if (place_meeting(x + hsp, y, oWall)
    || place_meeting(x + hsp, y, oBaseEnemy))
{
	while (abs(hsp) > 0.1)
	{
		hsp *= 0.5;
		if (!place_meeting(x + hsp, y, oWall)
			&& !place_meeting(x + hsp, y, oBaseEnemy)) 
			x += hsp;
	}
	hsp = 0;
}
x += hsp;

if (place_meeting(x, y + vsp, oWall)
	|| place_meeting(x, y + vsp, oBaseEnemy))
{
	while (abs(vsp) > 0.1)
	{
		vsp *= 0.5;
		if (!place_meeting(x, y + vsp, oWall)
		    && !place_meeting(x, y + vsp, oBaseEnemy))
			y += vsp;
	}
	vsp = 0;
	hsp = 0;
}
y += vsp;

