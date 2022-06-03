/// @description Fade in if current room is a level
if (room == rmInit || 
    room == rmTest || 
	room == rmLevelBase) 
{
	exit;
}

fadeColour = c_black;
fade_in();

