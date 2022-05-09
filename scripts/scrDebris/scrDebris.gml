function DebrisElement(_x, _y, _sprite, _width, _height, _spd, _dir, _rotateSpd, _lifetime, _wallObj = oWall) constructor
{
	X = _x;
	Y = _y;
	angle = irandom_range(0, 359);
	grv = 0.2;
	wallObj = _wallObj;
	hsp = lengthdir_x(_spd, _dir);
	vsp = lengthdir_y(_spd, _dir);
	rotateSpeed = _rotateSpd;
	maxLifetime = _lifetime * room_speed;
	lifetime = maxLifetime;
	width  = _width;
	height = _height;
	scale = 1;
	tX = irandom_range(0, sprite_get_width(_sprite)  - width);
	tY = irandom_range(0, sprite_get_height(_sprite) - height);
	
	function update()
	{
		vsp += grv;
		angle += rotateSpeed;
		lifetime--;
		scale = min((lifetime / maxLifetime) * 3, 1);
		
		// Collide and move
		if (collision_point(X + hsp, Y, wallObj, false, true))
		{
			while (abs(hsp) > 0.1)
			{
				hsp *= 0.5;
				if (!collision_point(X + hsp, Y, wallObj, false, true)) 
					X += hsp;
			}
			hsp = 0;
		}
		X += hsp;

		if (collision_point(X, Y + vsp, wallObj, false, true))
		{
			while (abs(vsp) > 0.1)
			{
				vsp *= 0.5;
				if (!collision_point(X, Y + vsp, wallObj, false, true))
					Y += vsp;
			}
			vsp = 0;
			hsp = 0;
		}
		Y += vsp;
	}
}

function create_debris(_sprite, _x, _y, _widthBound = new Bound(3, 5), _heightBound = new Bound(3, 5), _amountBound = new Bound(8, 16), _dirBound = new Bound(0, 359), _spdBound = new Bound(3, 8), _rotateSpdBound = new Bound(3, 15), _lifetimeBound = new Bound(1, 3))
{
	var inst = instance_create_layer(_x, _y, layer, oDebris);
	var debris = array_create(0);
	
	var count = get_int_inside_bound(_amountBound);
	for (var i = 0; i < count; i++)
	{
		array_push(debris, new DebrisElement(
			_x, _y, _sprite, get_int_inside_bound(_widthBound), get_int_inside_bound(_heightBound), get_real_inside_bound(_spdBound), get_real_inside_bound(_dirBound), get_real_inside_bound(_rotateSpdBound), get_real_inside_bound(_lifetimeBound)
		));
	}
	
	inst.sprite_index = _sprite;
	inst.init(debris);
}

