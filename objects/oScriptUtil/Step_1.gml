/// @description Add game name and version to debug menu

if (!global.drawDebugItems) return;

add_debug_text(verString);
add_debug_text(gmVerString);
add_debug_text("");
add_debug_text(format_string("FPS: {0}", fps_real));
add_debug_text("");

