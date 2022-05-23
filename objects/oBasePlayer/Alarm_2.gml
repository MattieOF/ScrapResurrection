/// @description Disable effects of melee
walkSpeed = baseWalkSpeed;
if (meleeAttack != noone)
	instance_destroy(meleeAttack);
state = playerState.normal;
sprite.image_speed = 1;

