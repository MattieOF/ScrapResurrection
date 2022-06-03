/// @description Initialise debris
debris = instance_create_layer(x, y, layer, oDebris);
debris.sprite_index = sSpark;
debris.init(array_create(0), false);
alarm[0] = 1;

