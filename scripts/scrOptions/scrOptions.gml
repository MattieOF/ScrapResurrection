ini_open("options.ini");
global.skipIntro = ini_read_bool("Misc", "SkipIntro", false);
ini_close();

