/// @description Particle effect
var ang = angle_reverse(direction);
create_debris(sExplosion, x, y, new Bound(3, 5), new Bound(3, 5), new Bound(1, 1), new Bound(ang, ang), new Bound(3, 4),,new Bound(1, 1.5));
alarm[0] = 1;

