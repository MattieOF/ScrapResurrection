/// @description Init values, declare functions

enum playerState
{
	normal,
	shootingHook,
	missedHook,
	grappling,
	swingingMelee
}

function state_string()
{
	switch (state)
	{
		case playerState.normal:
			return "Normal";
		case playerState.shootingHook:
			return "Shooting Hook";
		case playerState.missedHook:
			return "Missed Hook";
		case playerState.grappling:
			return "Grappling";
		case playerState.swingingMelee:
			return "Swinging Melee";
	}
}

active = false;
hsp = 0;
vsp = 0;
canJump = jumpFrames;
dsp = 0;
_currentDashTime = 0;
maxDashCharges = dashCharges;
baseWalkSpeed = walkSpeed;
floating = false;
_currentExtraJumps = extraJumps;
_currentHookLen = 0;
_hookDir = 0;
_gX = 0;
_gY = 0;
_grappleCooldown = 0;
hp = baseHealth;
armor = 0;
meleeAttack = noone;
meleeAttackXOffset = 0;
meleeAttackYOffset = -16;
meleeDir = 0;
meleeSpriteWidth = 0;
_currentFootstepCooldown = 0;

xscale = 1;
yscale = 1;

// Weapon related variables
currentLoadoutSlot = -1;
loadout = array_create(0);
reloading = false;
reloadTime = 0;
shootCooldown = 0;

state = playerState.normal;

sprite = create_sprite(idleSprite, x, y, layer, 1, xscale, yscale);

function set_scale(_x, _y)
{
	xscale = _x;
	yscale = _y;
	image_xscale = _x;
	image_yscale = _y;
	sprite.image_xscale = _x;
	sprite.image_yscale = _y;
}

function is_grounded()
{
	return place_meeting(x, y + 1, oWall);
}

function on_hit(hitInfo)
{
	hurt(hitInfo.damage);
}

function hurt(dmg)
{
	// We're dead, don't bother
	if (hp <= 0)
		exit;
	
	// We're in dash iframes, don't take dmg
	if (dsp != 0)
		return;
		
	// Shake the screen depending on how much damage we're taking, only if active
	if (active)
		oGameManager.set_screenshake(min(dmg * hurtScreenshakeFactor, hurtScreenshakeCap));
	
	if (armor > 0)
	{
		// We have armor, take it from that first
		if (armor < dmg)
		{
			// We don't have enough armor to absorb all the damage, so:
			// 1. Take what we can from the armor
			// 2. Ensure the armor is now zero
			dmg -= armor;
			armor = 0;
		}
		else
		{
			// Our armor can fully absorb the damage
			// Take the dmg from the armor, and return from the function
			armor -= dmg;
			return;
		}
	}
	
	// If there is still dmg to take after the armor, then subtract it from HP
	hp -= dmg;
	
	if (hp <= 0)
		die();
}

function die()
{
	oGameManager.death(oGameManager.index_of_player(id));
}

function add_armor(amount)
{
	armor += amount;
	if (armor > maxArmor)
		armor = maxArmor;
}

// -------------------------
// Loadout related functions
// -------------------------
function add_weapon(_weapon)
{
	array_push(loadout, new LoadoutItem(_weapon));
}

function remove_weapon(_weapon)
{
	for (var i = 0; i < array_length(loadout); i++)
	{
		if (loadout[i].weapon == _weapon)
		{
			array_delete(loadout, i, 1);
			if (i != array_length(loadout))
				i--;
		}
	}
}

function current_weapon()
{
	if (array_length(loadout) <= currentLoadoutSlot || currentLoadoutSlot < 0)
		return pointer_null;
	else
		return loadout[currentLoadoutSlot];
}

function switch_weapon(index)
{
	if (state == playerState.swingingMelee) return;
	
	if (array_length(loadout) == 0)
	{
		currentLoadoutSlot = -1;
		return false;
	}
	
	if (index >= array_length(loadout))
		index = 0;
	else if (index < 0)
		index = array_length(loadout) - 1;
		
	if (reloading)
	{
		reloading = false;
		reloadTime = 0;
	}
		
	currentLoadoutSlot = index;
	return true;
}

function next_weapon()
{
	switch_weapon(currentLoadoutSlot + 1);
}

function previous_weapon()
{
	switch_weapon(currentLoadoutSlot - 1);
}

function shoot()
{
	// Return if we can't shoot right now
	if (reloading) return; // Currently reloading
	if (currentLoadoutSlot == -1) return; // No valid weapon selected
	if (shootCooldown > 0) return; // On shoot cooldown
	if (!loadout[currentLoadoutSlot].weapon.auto && !control_check_pressed(controls.primaryFire)) return; // Non auto weapon, but we're holding the button
	
	// Get direction to fire weapon
	var dir = point_direction(x, y, mouse_x, mouse_y);
	
	switch (loadout[currentLoadoutSlot].weapon.type)
	{
		case weaponType.melee:
			var wpn = loadout[currentLoadoutSlot].weapon;
			
			// Get direction
			if (mouse_x < x)
				meleeDir = true;
			else
				meleeDir = false;
			
			// Create an initialise melee attack object
			meleeAttack = instance_create_layer(x + (meleeDir == false ? wpn.xOffset : -(wpn.xOffset)),
				y + wpn.yOffset, layer, oMelee);
			meleeAttack.init(wpn.width, wpn.height, wpn, id);
			meleeAttack.image_angle = meleeDir ? 180 : 0;
			meleeSpriteWidth = sprite_get_width(meleeAttack.sprite_index);
			
			// Update movement speed
			walkSpeed *= wpn.speedMultiplier;
			
			// Set attack offsets
			meleeAttackXOffset = meleeDir == false ? wpn.xOffset : -(wpn.xOffset);
			meleeAttackYOffset = wpn.yOffset;
			
			// Disable effects of melee after attack time has passed
			alarm[2] = wpn.attackTime * room_speed;
			
			// Setup sprite speed
			if (meleeAttackSprite != noone)
			{
				sprite.image_index = 0;
				sprite.image_speed = (sprite_get_number(meleeAttackSprite) / sprite_get_speed(meleeAttackSprite)) / (wpn.attackTime);
			}
			
			// Set state
			state = playerState.swingingMelee;
			
			// Play sound
			play_sound_if_exists(loadout[currentLoadoutSlot].weapon.sounds.soundShoot, 1, false);
			
			// Set weapon cooldown
			shootCooldown = loadout[currentLoadoutSlot].weapon.rof * room_speed;
			break;
		case weaponType.hitscan:
			if (loadout[currentLoadoutSlot].ammoClip <= 0) 
			{
				play_sound_if_exists(loadout[currentLoadoutSlot].weapon.sounds.soundDryFire, 1, false);
				shootCooldown = loadout[currentLoadoutSlot].weapon.rof * room_speed;
				oHUD.ammoTextScale = 1.25;
				return;
			}
			
			var spread = loadout[currentLoadoutSlot].weapon.spread;
			repeat (loadout[currentLoadoutSlot].weapon.shots)
			{
				var shotDir = dir + random_range(-spread, spread);
				shoot_hitscan(id, shotDir, loadout[currentLoadoutSlot].weapon);
			}
			
			play_sound_if_exists(loadout[currentLoadoutSlot].weapon.sounds.soundShoot, 1, false);
			shootCooldown = loadout[currentLoadoutSlot].weapon.rof * room_speed;
			loadout[currentLoadoutSlot].ammoClip--;
			break;
		case weaponType.projectile:
			if (loadout[currentLoadoutSlot].ammoClip <= 0) 
			{
				play_sound_if_exists(loadout[currentLoadoutSlot].weapon.sounds.soundDryFire, 1, false);
				shootCooldown = loadout[currentLoadoutSlot].weapon.rof * room_speed;
				return;
			}
			
			var spread = loadout[currentLoadoutSlot].weapon.spread;
			var shotDir = dir + random_range(-spread, spread);
			play_sound_if_exists(loadout[currentLoadoutSlot].weapon.sounds.soundShoot, 1, false);
			// create_projectile(x + lengthdir_x(16, dir), y + lengthdir_y(16, dir), loadout[currentLoadoutSlot].weapon.projectile, shotDir);
			shootCooldown = loadout[currentLoadoutSlot].weapon.rof * room_speed;
			loadout[currentLoadoutSlot].ammoClip--;
			break;
	}
}

function reload_pressed()
{
	// Return if we can't reload
	if (reloading) return; // Already reloading
	if (!variable_struct_exists(loadout[currentLoadoutSlot], "ammoClip")) return; // Ammoless weapon
	if (loadout[currentLoadoutSlot].ammoClip == loadout[currentLoadoutSlot].weapon.ammoClip) 
		return;  // Clip is full
	if (loadout[currentLoadoutSlot].ammoReserve == 0) return; // Out of reserve ammo
	
	play_sound_if_exists(loadout[currentLoadoutSlot].weapon.sounds.soundReload, 1, false);
	
	reloading = true;
	reloadTime = loadout[currentLoadoutSlot].weapon.reloadTime * room_speed;
}

function reload()
{
	var needed = loadout[currentLoadoutSlot].weapon.ammoClip - loadout[currentLoadoutSlot].ammoClip;
	var toBeAdded = min(loadout[currentLoadoutSlot].ammoReserve, needed);
	
	loadout[currentLoadoutSlot].ammoClip += toBeAdded;
	loadout[currentLoadoutSlot].ammoReserve -= toBeAdded;
}

alarm[0] = 1;

add_weapon(global.weaponDagger);
next_weapon();

if (global.gameSave != undefined && global.gameSave[$ "characters"][$ saveId] != undefined)
{
	hp = global.gameSave[$ "characters"][$ saveId][$ "hp"];
	armor = global.gameSave[$ "characters"][$ saveId][$ "armor"];
	loadout = global.gameSave[$ "characters"][$ saveId][$ "loadout"];
}

