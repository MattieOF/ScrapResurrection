event_user(0);

function draw()
{
	if (sprite == noone) return;
	draw_sprite_ext(sprite, frame, x, y, scale, scale, 0, color, alpha);
}
