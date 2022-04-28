/// @description Follow target

if (instance_exists(target))
{
	xTo = target.x;
	yTo = target.y;
}

x += (xTo - x) / cameraMoveFractionPerFrame;
y += (yTo - y) / cameraMoveFractionPerFrame;

var vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0);
var pm = matrix_build_projection_ortho(width, height, 1, 10000);

camera_set_view_mat(camera, vm);
camera_set_proj_mat(camera, pm);

