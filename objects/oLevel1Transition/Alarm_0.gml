/// @description Do screenshake, save game, create level end UI
oGameManager.screenshakeDecreasePerFrame = 0.5;
save(, rmLevel2);

window_set_cursor(cr_default);
oGameManager.current_character().active = false;
var inst = instance_create_layer(0, 0, layer, oMissionEndScreen);
inst.init(oGameManager.killScore, oGameManager.time / room_speed, rmLevel2, c_black);

