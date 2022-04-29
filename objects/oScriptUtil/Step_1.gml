/// @description Add game name and version to debug menu

if (!global.drawDebugItems) return;

add_debug_text(format_string("{0} v{1}, built at {2} on {3}", game_display_name, GM_version, date_time_string(GM_build_date), date_date_string(GM_build_date)));
add_debug_text(format_string("Running on runtime v{0}", GM_runtime_version));
add_debug_text("");

