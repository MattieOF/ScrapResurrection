/// @description Hurt hittable
if (other.id != src)
{
	other.on_hit(new HitInfo(damage, src));
	instance_destroy(id);
}

