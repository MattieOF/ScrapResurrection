/// @description Debug related help functions
global.drawDebugItems = false;
global.debugItems = ds_list_create();
function add_debug_text(msg)
{
	ds_list_add(global.debugItems, msg);
}

