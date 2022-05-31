// While I was orginally planning to have full level state (de)serialisation implemented
// for saving and loading, that was a lot of work that I really could not be arsed with.
// Therefore, I've decided to instead take advantage of this games level-based approach,
// as well as the fact that each level is quite short. Instead of saving the state of the
// level, we'll instead just save which level we're on, and some player state like HP and 
// loadout. 

// In a full implementation of the game, it would still be best to have checkpoints within
// the levels. At that point, you might as well just have full level serialisation.
// Perhaps I could simply have checkpoints that save the players position, HP, ammo, etc
// and return to them when they die without reloading the level so everything is the same,
// but that means things after the checkpoint also remain, which I think 
// 1) feels a bit weird
// 2) goes agaisnt the somewhat difficult design of the game

// Overall, for now, I think we'll just do some basic saving.

global.gameSave = undefined;

function default_save(filename = "save.json")
{
	if (file_exists(filename))
		file_copy(filename, filename + ".bak");
	
	global.gameSave = 
	{
		currentLevel : room,
		characters : { }
	}
	
	with (oBasePlayer)
	{
		global.gameSave[$ "characters"][$ saveId] = { };
		global.gameSave[$ "characters"][$ saveId][$ "hp"] = hp;
		global.gameSave[$ "characters"][$ saveId][$ "armor"] = armor;
		global.gameSave[$ "characters"][$ saveId][$ "loadout"] = loadout;
	}
	
	if (file_exists(filename)) file_delete(filename);
	
	var file = file_text_open_write(filename);
	file_text_write_string(file, json_stringify(global.gameSave));
	file_text_close(file);
}

function save(filename = "save.json")
{
	if (global.gameSave == undefined)
		default_save();
	else
	{
		global.gameSave[$ "currentLevel"] = room;
		
		with (oBasePlayer)
		{
			global.gameSave[$ "characters"][$ saveId][$ "hp"] = hp;
			global.gameSave[$ "characters"][$ saveId][$ "armor"] = armor;
			global.gameSave[$ "characters"][$ saveId][$ "loadout"] = loadout;
		}
		
		if (file_exists(filename)) file_delete(filename);
		
		var file = file_text_open_write(filename);
		file_text_write_string(file, json_stringify(global.gameSave));
		file_text_close(file);
	}
}

function load(filename = "save.json")
{
	if (!file_exists(filename))
	{
		room_goto(rmLevel1);
		return;
	}
	
	var file = file_text_open_read(filename);
	global.gameSave = json_parse(file_text_read_string(file));
	file_text_close(file);
	
	room_goto(global.gameSave[$ "currentLevel"]);
}

