/// @description Raycasting function
// From https://marketplace.yoyogames.com/assets/8889/raycast-2d

///@desc raycast(x, y, dir, range, obj);
///@arg x
///@arg y
///@arg dir
///@arg range
///@arg obj
function raycast(_x, _y, _dir, _range, _objToCollide) {

	/*
		Shoot out a ray which travels a certain distance until it collides with something.
		The longer the range, the bigger the toll on your performance, try to keep it as small as possible.
	
		x:		the x position to start the ray from
		y:		the y position to start the ray from
		dir:	the direction the ray travels
		range:	how many pixels the ray travels
		obj:	what object to check for collisions (usually just set to 'all' unless you really need it specific)
	
		Returns a DS Map with these values:
		"x":				 the x position that the ray ended
		"y":				 the y position that the ray ended
		"x_origin":			 the x position that the ray started
		"y_origin":			 the y position that the ray started
		"obj":				 the object the ray collided with or noone
		"distance":			 the distance in pixels between the start of the ray and the end of the ray
							 (distance just equals the range argument if there was no collision)
	
	*/

	var _xA, _yA, _rangeCount;

	var _col;
	var _list = 
	{
		obj : noone,
		distance : _range,
		X : _x + lengthdir_x(_range, _dir),
		Y : _y + lengthdir_y(_range, _dir),
		xOrigin : _x,
		yOrigin : _y
	}


	_col = collision_line(_x, _y, _x + lengthdir_x(_range, _dir), _y + lengthdir_y(_range, _dir), _objToCollide, true, true);

	if (_col)
	{
		_xA = 0;
		_yA = 0;
		_rangeCount = 1;

		while ((!collision_line(_x, _y, _x + _xA, _y + _yA, _objToCollide, true, true)) && (_rangeCount < _range))
		{
		    _xA = lengthdir_x(_rangeCount, _dir);
		    _yA = lengthdir_y(_rangeCount, _dir);
	
			_rangeCount++;
		}

		_list.distance = _rangeCount;
		_list.X = _x + _xA;
		_list.Y = _y + _yA;
		_list.xOrigin = _x;
		_list.yOrigin = _y;

		_col = collision_line(_x, _y, _x+_xA, _y+_yA, _objToCollide, true, true);
	
	}
	
	_list.obj = _col;

	return _list;
}

