/// @description Movement

// Movement code adapted from https://www.youtube.com/watch?v=ywgkXbHYJNE

var keyRight = active ? control_check(controls.right) : 0;
var keyLeft  = active ? control_check(controls.left) : 0;
var keyJump  = active ? control_check(controls.jump) : 0;

add_debug_text(name);
add_debug_text(format_string("Pos:      [X: {0}, Y: {1}]", x, y));
add_debug_text(format_string("Movement: [Right: {0}, Left: {1}, Jump: {2}]", keyRight, keyLeft, keyJump));
add_debug_text("");

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


