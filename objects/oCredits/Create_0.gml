/// @description Init values

active = false;
image_alpha = 0;

// 0 = fade in lgoo
// 1 = keep logo
// 2 = fade out logo
// 3 = fade in people
// 4 - keep people
// 5 = fade out people
// 6 = fade in other
// 7 = keep other
// 8 = fade other
stage = 0;
alpha = 0;
skipAlpha = 0;
showSkip = true;
text = scribble("[fa_top][fa_left][sLogo]");
quitText = scribble("[fa_left][fa_bottom][c_white][fntUiMain]Press [c_yellow][[" + string(control_get_string(controls.quit)) + "] [c_white]to skip");
timer = 3 * room_speed;

