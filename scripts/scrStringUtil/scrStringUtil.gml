/// @desc Get the current date and time in a format usable in a file name
/// @returns date/time in format "current day_current month_current year-current hour_current minute_current second"
function get_file_formatted_datetime()
{
	return (string(current_day) + "_" + string(current_month) + "_" + string(current_year) + "-" + 
		string(current_hour) + "_" + string(current_minute) + "_" + string(current_second));
}

/// @desc Format a string, replacing each substring in format "{i}" with argument i cast to a string
/// @param {string} str - String to be formatted
function format_string()
{
	var _str = argument[0];
	
	for (var i = 1; i < argument_count; i++)
	{
		var identifier = "{" + string(i - 1) + "}";
		_str = string_replace(_str, identifier, string(argument[i]));
	}
	
	return _str;
}

/// @desc Format a string, replacing each substring in format "{i}" with argument i cast to a string, and use it with show_debug_message
/// @param {string} str - String to be formatted
function log_format_string()
{
	var _str = argument[0];
	
	for (var i = 1; i < argument_count; i++)
	{
		var identifier = "{" + string(i - 1) + "}";
		_str = string_replace(_str, identifier, string(argument[i]));
	}
	
	show_debug_message(_str);
}

