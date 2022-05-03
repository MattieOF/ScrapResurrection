/// @description Movement

// Movement code adapted from https://www.youtube.com/watch?v=ywgkXbHYJNE

var keyRight = active ? control_check(controls.right) : 0;
var keyLeft  = active ? control_check(controls.left) : 0;
var keyJump  = active ? control_check(controls.jump) : 0;
var keyDash  = active ? control_check_pressed(controls.dash) : 0;

if (global.drawDebugItems)
{
	add_debug_text(format_string("{0}{1}", name, active ? " [ACTIVE]" : ""));
	add_debug_text(format_string("Pos:          [X: {0}, Y: {1}]", x, y));
	add_debug_text(format_string("Movement:     [Right: {0}, Left: {1}, Jump: {2}]", keyRight, keyLeft, keyJump));
	add_debug_text(format_string("Dash Speed:   {0}", dsp));
	add_debug_text(format_string("Dash Time:    {0}", _currentDashTime));
	add_debug_text(format_string("Dash Charges: {0}", dashCharges));
	add_debug_text("");
}

hsp = (keyRight - keyLeft) * walkSpeed;
vsp += grv;

if ((canJump-- > 0) && keyJump)
{
	vsp = -jumpHeight;
	canJump = 0;
}

// Dash related code
if (dsp != 0)
	dsp = approach(dsp, 0, 3);

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
}
x += hsp;
x += dsp;

if (place_meeting(x, y + vsp, oWall))
{
	if (vsp > 0) canJump = jumpFrames;
	while (abs(vsp) > 0.1)
	{
		vsp *= 0.5;
		if (!place_meeting(x, y + vsp, oWall)) y += vsp;
	}
	vsp = 0;
}
y += vsp;


