/// @description Initialise camera

// Code adapted from https://www.youtube.com/watch?v=Pd54vNc2N4E

width = 960;
height = 540;

function set_target(newTarget, instant)
{
	if (instance_exists(newTarget))
	{
		target = newTarget;
		xTo = target.x;
		yTo = target.y;
		
		if (instant)
		{
			x = xTo;
			y = yTo;
		}
	} 
	else 
	{
		log_format_string("Attempted to switch camera ({0}) target to non existent instance! ({1})", 
			id, newTarget);
	}
}

function time_to_move_to_target(newTarget)
{
	var curX = x;
	var curY = x;
	var newX = newTarget.x;
	var newY = newTarget.y;
	
	var steps = 0;
	
	while (abs(newX - curX) > 0.5 || abs(newY - curY) > 0.5)
	{
		curX += (newX - curX) / cameraMoveFractionPerFrame;
		curY += (newY - curY) / cameraMoveFractionPerFrame;
		steps++;
		
		// Failsafe: we've been going for way too long
		if (steps > 400)
			return steps;
	}
	
	return steps;
}

camera = camera_create();

var vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0);
var pm = matrix_build_projection_ortho(width, height, 1, 10000);

camera_set_view_mat(camera, vm);
camera_set_proj_mat(camera, pm);

view_enabled = true;
view_visible[0] = true;
view_camera[0] = camera;

displayScale = 1.5; // Size of the window relative to the size of the viewport
global.displayWidth = width * displayScale;
global.displayHeight = height * displayScale;

// Set window properties
window_set_size(global.displayWidth, global.displayHeight);

// Set render surface to the size of the window, not the size of the camera
surface_resize(application_surface, global.displayWidth, global.displayHeight);
display_set_gui_size(global.displayWidth, global.displayHeight); // Same for GUI

// Center window after one frame
if (!centeredWindow)
	alarm[0] = 1;

xTo = x;
yTo = y;
xOffset = 0;
yOffset = 0;
angle = 0;

// Initialise values for smoothing
_xOffsetCurrent = xOffset;
_yOffsetCurrent = yOffset;
_widthCurrent = width;
_heightCurrent = height;
_angleCurrent = 0;

