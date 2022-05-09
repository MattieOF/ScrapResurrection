global.weaponHitscan = new WeaponHitscan("Test Hitscan", sTestEnemy, 25, 1000, 0.75, 2, 10, 40, 
	new WeaponSounds(), 1, 0, false);

enum weaponType
{
	projectile,
	hitscan,
	melee
}

function LoadoutItem(_weapon) constructor
{
	weapon = _weapon;
	if (variable_struct_exists(_weapon, "ammoClip"))
	{
		ammoClip = _weapon.ammoClip;
		ammoReserve = _weapon.ammoReserve;
	}
}

function WeaponSounds(_shoot = undefined, _reload = undefined) constructor
{
	soundShoot = _shoot;
	soundReload = _reload;
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

//function create_projectile(_x, _y, _projectile, _dir)
//{
//	if (global.projectileLayer == undefined || !layer_exists(global.projectileLayer)) global.projectileLayer = layer_create(-500, "Projectiles");
//	var proj = instance_create_layer(_x, _y, global.projectileLayer, global.projectileObject);
//	proj.init(_projectile, _dir, 1);
//}


