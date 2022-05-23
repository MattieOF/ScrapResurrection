/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (sprite_index == sDroneSpawnerAsleep && awake && targetInView)
	sprite_index = sDroneSpawnerAwake;
else if (sprite_index == sDroneSpawnerAwake && !targetInView)
	sprite_index = sDroneSpawnerAsleep;

