/// @description Draw fade
if (currentFade <= 0) exit;

draw_set_color(fadeColour);
draw_set_alpha(currentFade);
draw_rectangle(0, 0, global.displayWidth, global.displayHeight, false);
draw_set_color(c_white);
draw_set_alpha(1);

