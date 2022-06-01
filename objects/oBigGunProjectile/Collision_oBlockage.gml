/// @description Hurt hittable
create_debris(sBlockage, other.x, other.y, new Bound(3, 5), new Bound(3, 5), new Bound(80, 100), new Bound(0, 360), new Bound(2, 6),,new Bound(2, 5));
instance_destroy(other);
instance_destroy(id);

