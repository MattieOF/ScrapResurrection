/// @description Deal damage to enemy if we're dashing
if (dsp > 0)
	other.on_hit(new HitInfo(dashDmg, id));

