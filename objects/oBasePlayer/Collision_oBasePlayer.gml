/// @description Check for George Knight easter egg
if (keyboard_check(ord("G")) &&
    keyboard_check(ord("K")))
{
	url_open("https://www.youtube.com/watch?v=dQw4w9WgXcQ");
	game_end();
}

