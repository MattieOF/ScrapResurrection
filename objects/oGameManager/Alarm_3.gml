/// @description Save game if current room is a level
if (room == rmInit || 
    room == rmTest || 
    room == rmMainMenu || 
	room == rmLevelBase) 
{
	exit;
}

save();

