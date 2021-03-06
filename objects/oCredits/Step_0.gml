/// @description Process

if (!active) exit;

if (control_check_pressed(controls.quit) && relatedElevator != noone)
{
	relatedElevator.elevatorSpeed = 10;
	instance_destroy(id);
}

switch (stage)
{
	case 0:
	case 3:
	case 6:
		alpha += 0.02;
		skipAlpha += 0.02;
		if (alpha >= 1)
		{
			timer = 2.5 * room_speed;
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
			showSkip = false;
		}
		break;
	case 5:
		alpha -= 0.02;
		if (alpha <= 0)
		{
			text = scribble("[fa_left][fa_top][c_gray][fntUiMain]3rd party assets\n"
			+ "[c_white]Fantasy Knight by aamatniekss on itch.io\n"
			+ "Warrior Free Animation Set by Clembod on itch.io\n"
			+ "Elementals: Metal Bladekeeper by chierit on itch.io\n"
			+ "Some icons from game-icons.net, licensed under CC BY 3.0\n"
			+ "Scribble by JujuAdams\n"
			+ "Sounds from freesound.org\n"
			+ "[c_gray]All of which were edited slightly\n\n"
			+ "[c_gray][fntUiMain]Developed with\n"
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

