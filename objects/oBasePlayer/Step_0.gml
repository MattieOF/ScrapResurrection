/// @description Movement

// Movement code adapted from https://www.youtube.com/watch?v=ywgkXbHYJNE

add_debug_text(format_string("X: {0}, Y: {1}", x, y));

var keyRight = control_check(controls.right);
var keyLeft  = control_check(controls.left);
var keyJump  = control_check(controls.jump);

// add_debug_text(format_string("Right: {0}, Left: {1}, Jump: {2}", keyRight, keyLeft, keyJump));

hsp = (keyRight - keyLeft) * walkSpeed;
vsp += grv;

if ((canJump-- > 0) && keyJump)
{
	vsp = -jumpHeight;
	canJump = 0;
}

// Collide and move
if (place_meeting(x + hsp, y, oWall))
{
	while (abs(hsp) > 0.1)
	{
		hsp *= 0.5;
		if (!place_meeting(x + hsp, y, oWall)) x += hsp;
	}
	hsp = 0;
}
x += hsp;

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


