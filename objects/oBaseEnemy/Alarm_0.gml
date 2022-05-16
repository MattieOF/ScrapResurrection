/// @description Check for target and do pathfinding

if (target == noone || !targetInView)
{
	with (targetObject)
	{
		if (collision_line(other.x, other.y, x, y, oWall, false, true) == noone /* We have line of sight */
		    && point_distance(other.x, other.y, x, y) <= other.wakeRadius /* We are close enough */)
		{
			// Enemy should be awoken
			if (!other.awake)
				other.wakeRadius *= 2; // Once awaken for the first time, enemy awakes easier
				
			other.awake = true;
			other.target = id;
			other.targetInView = true;
			other.targetLastX = x;
			other.targetLastY = y;
		}
	}
}
else
{	
	with (target)
	{
		if (collision_line(x, y, other.x, other.y, oWall, false, true) == noone)
		{
			other.targetLastX = x;
			other.targetLastY = y;
			other.targetInView = true;
		} 
		else 
		{
			other.targetLastX = x;
			other.targetLastY = y;
			other.targetInView = false;
		}
	}
}

alarm[0] = 15;

