/// @description Movement

// Movement code adapted from https://www.youtube.com/watch?v=ywgkXbHYJNE

var keyRight = active ? control_check(controls.right) : 0;
var keyLeft  = active ? control_check(controls.left) : 0;
var keyJump  = active ? control_check(controls.jump) : 0;
var keyDash  = active ? control_check_pressed(controls.dash) : 0;
var keyHook  = active ? control_check(controls.grapplingHook) : 0;

if (global.drawDebugItems)
{
	add_debug_text(format_string("{0}{1}", name, active ? " [ACTIVE]" : ""));
	add_debug_text(format_string("Health:       {0}", hp));
	add_debug_text(format_string("Pos:          [X: {0}, Y: {1}]", x, y));
	add_debug_text(format_string("H/VSP:        [H: {0}, V: {1}]", hsp, vsp));
	add_debug_text(format_string("Movement:     [Right: {0}, Left: {1}, Jump: {2}]", keyRight, keyLeft, keyJump));
	add_debug_text(format_string("Dash Speed:   {0}", dsp));
	add_debug_text(format_string("Dash Time:    {0}", _currentDashTime));
	add_debug_text(format_string("Dash Charges: {0}", dashCharges));
	add_debug_text(format_string("Floating:     {0}", floating ? "True" : "False"));
	add_debug_text(format_string("EJumps Left:  {0}", _currentExtraJumps));
	add_debug_text(format_string("State:        {0}", state_string()));
	add_debug_text("");
}

hsp = (keyRight - keyLeft) * walkSpeed;
if (!floating) vsp += grv;

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
			_hookDir += clamp(angle_difference(targetDir, _hookDir), -2.5, 2.5);
			_currentHookLen += grappleSpeed;
			
			var hit = raycast(x, y, _hookDir, _currentHookLen, oWall);
			if (hit.obj != noone)
			{
				state = playerState.grappling;
			}
			_gX = hit.X;
			_gY = hit.Y;
			
			break;
		case playerState.grappling:
			_hookDir = point_direction(x, y, _gX, _gY);
			hsp = lengthdir_x(grappleSpeed, _hookDir);
			vsp = lengthdir_y(grappleSpeed, _hookDir);

			break;
	}
}
else
	state = playerState.normal;

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

if (keyDash && dashCharges > 0)
{
	_currentDashTime = dashRecharge * room_speed;
	if (dashCharges == 0)
		_currentDashTime *= outOfDashPenalty;
	dashCharges--;
	
	var _dir = sign(hsp);
	if (_dir == 0) _dir = 1;
	dsp = _dir * dashSpeed;
	vsp = 0;
	
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


