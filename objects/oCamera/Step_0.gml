/// @description Follow target

// If target exists, set target pos to its position plus current offset
if (instance_exists(target))
{
	xTo = target.x + _xOffsetCurrent;
	yTo = target.y + _yOffsetCurrent;
}

// Tick smooth values
x += (xTo - x) / cameraMoveFractionPerFrame;
y += (yTo - y) / cameraMoveFractionPerFrame;

_widthCurrent += (width - _widthCurrent) / cameraAdjustFractionPerFrame;
_heightCurrent += (height - _heightCurrent) / cameraAdjustFractionPerFrame;

_xOffsetCurrent += (xOffset - _xOffsetCurrent) / cameraAdjustFractionPerFrame;
_yOffsetCurrent += (yOffset - _yOffsetCurrent) / cameraAdjustFractionPerFrame;

_angleCurrent += (angle - _angleCurrent) / cameraAdjustFractionPerFrame;

// If the smooth value is close enough, change values to exact values
if (abs(xTo - x) < 0.5) x = xTo;
if (abs(yTo - y) < 0.5) y = yTo;
if (abs(_widthCurrent - width) < 0.5) _widthCurrent = width;
if (abs(_heightCurrent - height) < 0.5) _heightCurrent = height;
if (abs(_xOffsetCurrent - xOffset) < 0.5) _xOffsetCurrent = _xOffsetCurrent;
if (abs(_yOffsetCurrent - yOffset) < 0.5) _yOffsetCurrent = _yOffsetCurrent;
if (abs(_angleCurrent - angle) < 0.1) _angleCurrent = angle;

// Clamp the target coordinates to not let the camera go outside the room
var _x = clamp(x, _widthCurrent / 2, room_width - (_widthCurrent / 2));
var _y = clamp(y, _heightCurrent / 2, room_height - (_heightCurrent / 2));

// Build and set matrixes
var vm = matrix_build_lookat(_x, _y, -10, _x, _y, 0, _angleCurrent / 90, 1, 0);
var pm = matrix_build_projection_ortho(_widthCurrent, _heightCurrent, 1, 10000);

camera_set_view_mat(camera, vm);
camera_set_proj_mat(camera, pm);

if (global.drawDebugItems)
{
	add_debug_text("Camera");
	add_debug_text(format_string("Target Pos:            [X: {0}, Y: {1}]", xTo, yTo));
	add_debug_text(format_string("Current Pos:           [X: {0}, Y: {1}]", x, y));
	add_debug_text(format_string("Target Size:           [Width: {0}, Height: {1}]", width, height));
	add_debug_text(format_string("Current Size:          [Width: {0}, Height: {1}]", _widthCurrent, _heightCurrent));
	add_debug_text(format_string("Target Rotation:       {0}", angle));
	add_debug_text(format_string("Current Rotation:      {0}", _angleCurrent));
	add_debug_text(format_string("Speed Change Blocked:  {0}", global.speedChangeBlocked ? "True" : "False"));
	add_debug_text("");	
}

