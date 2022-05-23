/// @description Add explosion particles

repeat(16)
{
	var point = random_point_in_rect(bbox_left, bbox_top, bbox_right, bbox_bottom);
	if (point_in_triangle(point.X, point.Y, p1X, p1Y, p2X, p2Y, p3X, p3Y))
		add_debris_element(debris, point.X, point.Y, sExplosion, new Bound(8, 11), new Bound(8, 11), new Bound(1, 1), new Bound(0, 360), new Bound(0.1, 0.35),,new Bound(1, 2), new Bound(0, 0));
}

