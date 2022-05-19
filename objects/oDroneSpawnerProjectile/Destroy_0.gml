/// @description Particle effect
var reverseDir = angle_reverse(direction);
create_debris(sExplosion, x, y, new Bound(2, 3), new Bound(2, 3), new Bound(20, 25), new Bound(reverseDir - 20, reverseDir + 20), new Bound(1, 4));

