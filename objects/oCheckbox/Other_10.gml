/// @description Update width/height
var oldFont = draw_get_font();
if (font == noone) font = -1;
draw_set_font(font);
height = string_height(text);
width = string_width(text) + padding + height;
draw_set_font(oldFont);
