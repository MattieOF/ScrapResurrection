/// @description INI related helper functions
function ini_read_bool(section, key, valueDefault)
{
	var value = ini_read_string(section, key, valueDefault ? "true" : "false");
	value = string_lower(value);
	
	switch (value)
	{
		case "true": case "1":
			return true;
		case "false": case "0":
			return false;
		default:
			return valueDefault;
	}
}

function ini_write_bool(section, key, value)
{
	ini_write_string(section, key, value ? "true" : "false");
}

