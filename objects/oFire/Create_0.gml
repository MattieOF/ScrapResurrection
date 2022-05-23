/// @description Init everything

p1X = bbox_left + ((bbox_right - bbox_left) / 2);
p1Y = bbox_bottom;

p2X = bbox_left;
p2Y = bbox_top;

p3X = bbox_right;
p3Y = bbox_top;

debris = instance_create_layer(x, y, layer, oDebris);
debris.sprite_index = sExplosion;
debris.init(array_create(0), true);

var point = random_point_in_rect(bbox_left, bbox_top, bbox_right, bbox_bottom);
add_debris_element(debris, point.X, point.Y, sExplosion, new Bound(8, 11), new Bound(8, 11), new Bound(1, 1), new Bound(0, 360), new Bound(0.1, 0.35),,new Bound(1, 2), new Bound(0, 0));
		
