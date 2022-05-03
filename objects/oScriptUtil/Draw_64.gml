/// @description Draw debug items
if (!global.drawDebugItems) return;

var _y = 5;
for (var i = 0; i < ds_list_size(global.debugItems); i++)
{
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_text(5, _y, global.debugItems[| i]);
	_y += string_height("AAAAAAAAAAAAA");
}

