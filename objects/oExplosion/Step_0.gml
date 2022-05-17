/// @description Tick values

// Decrease anim time
_currentAnimTime--;

// Destroy if anim done
if (_currentAnimTime <= 0)
	instance_destroy(id);

