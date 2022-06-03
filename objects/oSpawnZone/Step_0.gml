/// @description Spawn enemy if its time to
if (!spawn) exit;

_currentTimer--;

if (_currentTimer <= 0)
{
	var point = random_free_point_in_rect(bbox_left, bbox_top, bbox_right, bbox_bottom, oWall);
	instance_create_layer(point.X, point.Y, layer, enemy);
	_currentTimer = timer;
}

