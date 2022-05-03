#macro options_filename "sr_options.ini"

function load_options()
{
	ini_open(options_filename);
	global.skipIntro = ini_read_bool("Misc", "SkipIntro", false);
	ini_close();
}

function save_options()
{
	ini_open(options_filename);
	ini_write_bool("Misc", "SkipIntro", global.skipIntro);
	ini_close();
}

load_options();
if (!file_exists(options_filename))
	save_options();

