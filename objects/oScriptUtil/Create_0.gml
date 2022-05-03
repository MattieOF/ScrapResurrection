/// @description Initialise static string

verString = format_string("{0} v{1}, built at {2} on {3}", game_display_name, GM_version, date_time_string(GM_build_date), date_date_string(GM_build_date));
gmVerString = format_string("Running on runtime v{0}", GM_runtime_version);
controlsJustReset = false;
resetControlsTimer = 2.5 * room_speed;
_currentResetControlsTimer = resetControlsTimer;

