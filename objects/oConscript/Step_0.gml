/// @description AI

if (_currentHurtTint > 0)
	_currentHurtTint -= 0.02;

// Attempt to jump up, and jump gaps
if (awake)
{
	switch (state)
	{
		case conscriptState.asleep:
			state = choose(conscriptState.melee, conscriptState.positioning);
			break;
		case conscriptState.meleePositioning:
			var dir = point_direction(x, y, targetLastX, targetLastY);
			hsp = lengthdir_x(walkSpeed, dir);
			
			if (place_meeting(x + (hsp * jumpDistance), y, oWall)
			    || !is_grounded_in_x((hsp * jumpDistance)))
					state = conscriptState.positioning;
			
			if (point_distance(x, y, target.x, target.y) < 32)
			{
				sprite.sprite_index = sConscriptAttackMelee;
				sprite.image_index = 0;
				state = conscriptState.melee;
			}
			
			break;
		case conscriptState.melee:
			if (sprite.image_index == sprite_get_number(sConscriptAttackMelee))
				state = conscriptState.meleePositioning;
			break;
		case conscriptState.positioning:
			
			break;
		case conscriptState.shooting:
			
			break;
	}
}

if (gag && !awake) exit;

// Collision code
vsp += grv;

if (place_meeting(x + hsp, y, oWall)
    || place_meeting(x + hsp, y, oBaseEnemy))
{
	while (abs(hsp) > 0.1)
	{
		hsp *= 0.5;
		if (!place_meeting(x + hsp, y, oWall)
			&& !place_meeting(x + hsp, y, oBaseEnemy)) 
			x += hsp;
	}
	hsp = 0;
}
x += hsp;

if (place_meeting(x, y + vsp, oWall)
	|| place_meeting(x, y + vsp, oBaseEnemy))
{
	while (abs(vsp) > 0.1)
	{
		vsp *= 0.5;
		if (!place_meeting(x, y + vsp, oWall)
		    && !place_meeting(x, y + vsp, oBaseEnemy))
			y += vsp;
	}
	vsp = 0;
	hsp = 0;
}
y += vsp;

// Update sprite
switch (state)
{
	case conscriptState.asleep:
		sprite.sprite_index = sConscriptIdle;
		break;
	case conscriptState.melee:
		sprite.sprite_index = sConscriptAttackMelee;
		break;
	case conscriptState.drawGun:
		sprite.sprite_index = sConscriptDraw;
		break;
	case conscriptState.shooting:
		sprite.sprite_index = sConscriptFire;
		break;
	default:
		if (vsp != 0)
			sprite.sprite_index = sConscriptRun;
		else
			sprite.sprite_index = sConscriptIdle;
		break;
}

if (hsp != 0)
	sprite.image_xscale = sign(hsp) * xscale;
	
sprite.image_angle = 0;


