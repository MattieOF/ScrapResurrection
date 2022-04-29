function load_options()
{
	ini_open("options.ini");
	global.skipIntro = ini_read_bool("Misc", "SkipIntro", false);
	ini_close();
}

function save_options()
{
	ini_open("options.ini");
	ini_write_bool("Misc", "SkipIntro", global.skipIntro);
	ini_close();
}

load_options();

