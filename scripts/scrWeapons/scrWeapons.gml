global.weaponPistol = new WeaponHitscan("Pistol", sTestEnemy, 25, 1000, 0.75, 2, 10, 40, 
	new WeaponSounds(), 1, 0, false);
global.weaponLMG = new WeaponHitscan("LMG", sTestEnemy, 15, 1000, 0.1, 2.5, 30, 120, 
	new WeaponSounds(), 1, 2.5, true);

enum weaponType
{
	projectile,
	hitscan,
	melee
}

function WeaponSounds(_shoot = undefined, _reload = undefined, _dryFire = undefined) constructor
{
	soundShoot = _shoot;
	soundReload = _reload;
	soundDryFire = _dryFire;
}

function WeaponHitscan(_name, _sprite, _damage, _range, _rof, _reloadTime, _clip, _reserve, _sounds, _shots = 1, _spread = 0, _auto = false) constructor
{
	type = weaponType.hitscan;
	name = _name;
	if (!sprite_exists(_sprite)) log_format_string("In weapon {0}, provided sprite doesn't exist.", _name);
	else sprite = _sprite;
	damage = _damage;
	range = _range;
	rof = _rof;
	reloadTime = _reloadTime;
	ammoClip = _clip;
	ammoReserve = _reserve;
	shots = _shots;
	spread = _spread;
	auto = _auto;
	if (!variable_struct_exists(_sounds, "soundShoot")) 
		log_format_string("In weapon {0}, provided WeaponSounds is invalid.", _name);
	else sounds = _sounds;
}

function WeaponProjectile(_name, _sprite, _projectile, _rof, _reloadTime, _clip, _reserve, _sounds, _spread = 0, _auto = true) constructor
{
	type = weaponType.projectile;
	name = _name;
	if (!sprite_exists(_sprite)) log_format_string("In weapon {0}, provided sprite doesn't exist.", _name);
	else sprite = _sprite;
	projectile = _projectile;
	rof = _rof;
	reloadTime = _reloadTime;
	ammoClip = _clip;
	ammoReserve = _reserve;
	spread = _spread;
	auto = _auto;
	if (!variable_struct_exists(_sounds, "soundShoot")) 
		log_format_string("In weapon {0}, provided WeaponSounds is invalid.", _name);
	else sounds = _sounds;
}

function WeaponMelee(_name, _sprite, _damage, _range, _rof, _sounds, _auto = false) constructor
{
	type = weaponType.melee;
	name = _name;
	if (!sprite_exists(_sprite)) log_format_string("In weapon {0}, provided sprite doesn't exist.", _name);
	else sprite = _sprite;
	damage = _damage;
	range = _range;
	rof = _rof;
	if (!variable_struct_exists(_sounds, "soundShoot")) 
		log_format_string("In weapon {0}, provided WeaponSounds is invalid.", _name);
	else sounds = _sounds;
	auto = _auto;
}

function Projectile(_sprite, _damage, _speed) constructor
{
	if (!sprite_exists(_sprite)) log_format_string("In a projectile, provided sprite ({0}) doesn't exist.", _sprite);
	else sprite = _sprite;
	damage = _damage;
	projectileSpeed = _speed;
}

function Tracer(_x, _y, _x2, _y2, _col = c_white, _startAlpha = 0.5, _startWidth = 2, _time = 0.5) constructor
{
	startX      = _x;
	startY      = _y;
	endX        = _x2;
	endY        = _y2;
	color       = _col;
	startAlpha  = _startAlpha;
	alpha       = startAlpha;
	startTime   = _time * room_speed;
	time        = startTime;
	startWidth  = _startWidth;
	width       = startWidth;
	
	function update()
	{
		time--;
		alpha = lerp(0, startAlpha, time / startTime);
		width = lerp(0, startWidth, time / startTime);
	}
	
	function draw()
	{
		draw_set_color(color);
		draw_set_alpha(alpha);
		draw_line_width(startX, startY, endX, endY, width);
		draw_set_color(c_white);
		draw_set_alpha(1);
	}
}

function create_tracer(_x, _y, _x2, _y2, _col = c_white, _startAlpha = 120, _time = 0.5)
{
	array_push(global.tracers, new Tracer(_x, _y, _x2, _y2, _col, _startAlpha, _time));
}

function shoot_hitscan(src, dir, _weapon, hittableObj = oHittable, wallObj = oWall)
{
	var hitRaycast  = raycast(src.x, src.y, dir, _weapon.range, hittableObj);
	var wallRaycast = raycast(src.x, src.y, dir, _weapon.range, wallObj);
	
	if (hitRaycast.obj == noone && wallRaycast.obj == noone)
		create_tracer(src.x, src.y, wallRaycast.X, wallRaycast.Y,,0.4);
	else if (hitRaycast.distance < wallRaycast.distance)
	{
		// Hit a hittable
		hitRaycast.obj.on_hit(new HitInfo(_weapon.damage, src));
		create_tracer(src.x, src.y, hitRaycast.X, hitRaycast.Y,,0.4);
	}
	else
	{
		// Hit a wall
		// Spawn debris
		var angle = round((angle_reverse(dir) / 45)) * 45;
		create_debris(sWallWNS, wallRaycast.X, wallRaycast.Y,,,,new Bound(angle - 8, angle + 8), new Bound(1, 2),,new Bound(0.6, 1.2));
		create_tracer(src.x, src.y, wallRaycast.X, wallRaycast.Y,,0.4);
	}
}

//function create_projectile(_x, _y, _projectile, _dir)
//{
//	if (global.projectileLayer == undefined || !layer_exists(global.projectileLayer)) global.projectileLayer = layer_create(-500, "Projectiles");
//	var proj = instance_create_layer(_x, _y, global.projectileLayer, global.projectileObject);
//	proj.init(_projectile, _dir, 1);
//}


