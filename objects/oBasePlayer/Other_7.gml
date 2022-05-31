/// @description Stop death sprite
if (sprite.sprite_index == deathSprite)
{
	sprite.image_index = sprite_get_number(deathSprite) - 1;
	sprite.image_speed = 0;
}

