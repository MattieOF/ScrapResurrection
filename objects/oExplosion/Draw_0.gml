/// @description Draw explosion
var time = _currentAnimTime / animTime;
draw_set_color(color_lerp(colourStart, colourEnd, time));
draw_set_alpha(min(time * 3, 1));
draw_circle_ext(x, y, lerp(radius, 0, time), 40, 0, 360, lerp(0, 20, time), true);
draw_set_alpha(min(time * 3, 0.2));
draw_circle_ext(x, y, lerp(radius, 0, time), 40, 0, 360, 1, false);
draw_set_color(c_white);
draw_set_alpha(1);

