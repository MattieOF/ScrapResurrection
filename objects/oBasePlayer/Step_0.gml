/// @description Update everything
/// This includes movement, shooting

// Movement code adapted from https://www.youtube.com/watch?v=ywgkXbHYJNE

var keyRight    = active ? control_check(controls.right) : 0;
var keyLeft     = active ? control_check(controls.left) : 0;
var keyJump     = active ? control_check(controls.jump) : 0;
var keyDash     = active ? control_check_pressed(controls.dash) : 0;
var keyHook     = active ? control_check(controls.grapplingHook) : 0;
var keyUse      = active ? control_check_pressed(controls.use) : 0;
var keyPrimary  = active ? control_check(controls.primaryFire) : 0;
var keyNext     = active ? control_check_pressed(controls.weaponNext) : 0;
var keyPrevious = active ? control_check_pressed(controls.weaponPrevious) : 0;
var keyReload   = active ? control_check_pressed(controls.reload) : 0;

if (global.drawDebugItems)
{
	add_debug_text(format_string("{0}{1}",      name, active ? " [ACTIVE]" : ""));
	add_debug_text(format_string("Health:       {0}", hp));
	add_debug_text(format_string("Armor:        {0}", armor));
	add_debug_text(format_string("Pos:          [X: {0}, Y: {1}]", x, y));
	add_debug_text(format_string("H/VSP:        [H: {0}, V: {1}]", hsp, vsp));
	add_debug_text(format_string("Movement:     [Right: {0}, Left: {1}, Jump: {2}]", keyRight, keyLeft, keyJump));
	add_debug_text(format_string("Dash Speed:   {0}", dsp));
	add_debug_text(format_string("Dash Time:    {0}", _currentDashTime));
	add_debug_text(format_string("Dash Charges: {0}", dashCharges));
	add_debug_text(format_string("Floating:     {0}", floating ? "True" : "False"));
	add_debug_text(format_string("EJumps Left:  {0}", _currentExtraJumps));
	add_debug_text(format_string("State:        {0}", state_string()));
	var weapon = current_weapon();
	var weaponName = (weapon == pointer_null ? "None" : weapon.weapon.name);
	add_debug_text(format_string("Weapon:       {0}", weaponName));
	var ammoString = (weapon.ammoClip == pointer_null ? "N/A" : format_string("{0}/{1}", string(weapon.ammoClip), string(weapon.ammoReserve)));
	add_debug_text(format_string("Ammo:         {0}", ammoString));
	add_debug_text("");
}

hsp = (keyRight - keyLeft) * walkSpeed;
if (!floating) vsp += grv;

if (global.flynnHook)
{
	grappleStartCol = make_color_hsv(((sin(current_time / 500) + 1) / 2) * 255, 255, 255);
	grappleEndCol = make_color_hsv((((sin(current_time / 500) + 1) / 2) * 255 - 100), 255, 255);
}

if (keyHook && hasGrapplingHook)
{	
	switch(state)
	{
		case playerState.normal:
			_hookDir = point_direction(x, y, mouse_x, mouse_y);
			state = playerState.shootingHook;
			_currentHookLen = 0;
			_gX = x;
			_gY = y;
			break;
		case playerState.shootingHook:
			var targetDir = point_direction(x, y, mouse_x, mouse_y);
			_gX = lengthdir_x(_currentHookLen, _hookDir) + x;
			_gY = lengthdir_y(_currentHookLen, _hookDir) + y;
			_hookDir += clamp(angle_difference(targetDir, _hookDir), 
				-grappleDirAdjustRate, grappleDirAdjustRate);
			_currentHookLen += grappleSpeed;
			
			var hit = raycast(x, y, _hookDir, _currentHookLen, oWall);
			if (hit.obj != noone)
			{
				var angleReverse = angle_reverse(_hookDir);
				var tex = global.tileTex;
				if (variable_instance_exists(hit.obj, "tileTex") && hit.obj.tileTex != noone)
					tex = hit.obj.tileTex;
				create_debris(tex, hit.X, hit.Y,,,,new Bound(angleReverse - 5, angleReverse + 5));
				state = playerState.grappling;
			}
			_gX = hit.X;
			_gY = hit.Y;
			
			// Missed hook
			if (_currentHookLen > grappleMaxLength)
			{
				state = playerState.missedHook;
			}
			
			break;
		case playerState.grappling:
			_hookDir = point_direction(x, y, _gX, _gY);
			hsp = lengthdir_x(grappleSpeed, _hookDir);
			vsp = lengthdir_y(grappleSpeed, _hookDir);

			break;
	}
}
else if (state != playerState.missedHook
		 && state != playerState.swingingMelee) // Player has missed hook, keep them in that state
	state = playerState.normal;
	
if (state == playerState.missedHook)
{
	_currentHookLen -= grappleSpeed;
	_gX = x + lengthdir_x(_currentHookLen, _hookDir);
	_gY = y + lengthdir_y(_currentHookLen, _hookDir);
	
	if (_currentHookLen < 0)
		state = playerState.normal;
}

if (((canJump-- > 0) || _currentExtraJumps > 0) && keyJump && state == playerState.normal)
{
	var isExtraJump = canJump <= 0;
	if (!isExtraJump || control_check_pressed(controls.jump))
	{
		vsp = -jumpHeight * (isExtraJump ? extraJumpPowerModifier : 1);
		if (isExtraJump) 
			_currentExtraJumps--;
		canJump = 0;
	}
}

// Dash related code
if (dsp != 0)
	dsp = approach(dsp, 0, dashDeaccelerationPerStep);

if (_currentDashTime > 0)
{
	_currentDashTime--;
	if (_currentDashTime == 0 && dashCharges < maxDashCharges)
	{
		dashCharges++;
		_currentDashTime = dashRecharge * room_speed;
	}
}

if (keyDash && dashCharges > 0 && state != playerState.swingingMelee)
{
	_currentDashTime = dashRecharge * room_speed;
	if (dashCharges == 0)
		_currentDashTime *= outOfDashPenalty;
	dashCharges--;
	
	var _dir = sign(hsp);
	if (_dir == 0) _dir = sign(sprite.image_xscale);
	dsp = _dir * dashSpeed;
	vsp = 0;
	
	var reverseDir = _dir ? -180 : 0;
	create_debris(sDash, x, y,,,new Bound(15, 20), new Bound(reverseDir - 30, reverseDir + 30), new Bound(5, 8));
	
	// Float (no gravity) for amount of time it takes to dsp to decrease to 0
	floating = true;
	alarm[1] = abs(dsp) / dashDeaccelerationPerStep; 
}

// Collide and move
if (place_meeting(x + hsp + dsp, y, oWall))
{
	while (abs(hsp + dsp) > 0.1)
	{
		hsp *= 0.5;
		dsp *= 0.5;
		if (!place_meeting(x + hsp + dsp, y, oWall)) 
		{
			x += hsp;
			x += dsp;
		}
	}
	hsp = 0;
	dsp = 0;
	
	if (canWallSlide && !floating && !is_grounded())
	{
		vsp = min(vsp, wallslideSpeed);
		// TODO: Wallsliding particle
	}
}
x += hsp;
x += dsp;

if (place_meeting(x, y + vsp, oWall))
{
	// Fall damage
	if (vsp > fallDmgStart && state != playerState.grappling)
		hurt((vsp - fallDmgStart) * fallDmgMultiplier);
	
	if (vsp > 0) 
	{
		canJump = jumpFrames;
		_currentExtraJumps = extraJumps;
	}
	while (abs(vsp) > 0.1)
	{
		vsp *= 0.5;
		if (!place_meeting(x, y + vsp, oWall)) y += vsp;
	}
	vsp = 0;
}
y += vsp;

// Update sprite
sprite.x = x;
sprite.y = y;

if (state == playerState.swingingMelee && meleeAttackSprite != noone)
	sprite.sprite_index = meleeAttackSprite;
else if (hsp != 0 && vsp == 0)
	sprite.sprite_index = runSprite;
else if (vsp > 0)
	sprite.sprite_index = jumpUpSprite;
else if (vsp < 0)
	sprite.sprite_index = jumpDownSprite;
else
	sprite.sprite_index = idleSprite;

if (state == playerState.swingingMelee)
	sprite.image_xscale = (meleeDir == 0 ? xscale : -xscale);
else if (hsp != 0)
	sprite.image_xscale = sign(hsp) * xscale;

if (shootCooldown > 0)
	shootCooldown--;
if (reloading)
	reloadTime--;

if (reloading && reloadTime <= 0)
{
	reload();
	reloading = false;
}

if (keyPrimary)
{
	// Shoot
	shoot();
}

if (keyNext)
	next_weapon();
else if (keyPrevious)
	previous_weapon();

if (keyReload)
	reload_pressed();

// Update melee
if (state == playerState.swingingMelee)
{
	meleeAttack.x = x + meleeAttackXOffset;
	meleeAttack.y = y + meleeAttackYOffset;
}

