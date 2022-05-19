/// @description Process

if (!active) exit;

switch (stage)
{
	case 0:
	case 3:
	case 6:
		alpha += 0.02;
		if (alpha >= 1)
		{
			timer = 2 * room_speed;
			stage++;
		}
		break;
	case 1:
	case 4:
	case 7:
		timer--;
		if (timer <= 0)
			stage++;
		break;
	case 2:
		alpha -= 0.02;
		if (alpha <= 0)
		{
			text = scribble("[fa_left][fa_top][c_gray][fntUiMain]Story, Level Design, and Art\n"
			+ "[c_white][fntUiMainLarge]Daniel Harvey\n\n"
			+ "[c_gray][fntUiMain]Character Designs and Music\n"
			+ "[c_white][fntUiMainLarge]Sophie Hayward\n\n"
			+ "[c_gray][fntUiMain]Programming and Sound\n"
			+ "[c_white][fntUiMainLarge]Matt Ware\n\n"
			+ "[c_gray][fntUiMain]Thanks to\n"
			+ "[c_white][fntUiMain]Ben, Sam, Milenne, Chris");
			stage++; 
		}
		break;
	case 5:
		alpha -= 0.02;
		if (alpha <= 0)
		{
			text = scribble("[fa_left][fa_top][c_gray][fntUiMain]Developed in\n"
			+ "[c_white][sGMLogo]\n\n"
			+ "[c_gray][fntUiMain]Developed at\n"
			+ "[c_white][sFCLogo]");
			stage++;
		}
		break;
	case 8:
		alpha -= 0.02;
		if (alpha <= 0)
		{
			instance_destroy(id);
		}
		break;
}

