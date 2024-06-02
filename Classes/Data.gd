extends Object

class_name Data

static func exists(path: String):
	return FileAccess.file_exists(path)

static func save_value(path: String, variable: Variant, stringify: bool = true):
	var file = FileAccess.open(path, FileAccess.WRITE_READ)
	if stringify:
		var value: String = JSON.stringify(variable)
		file.store_pascal_string(value)
	else:
		file.store_pascal_string(variable)
	file.close()

static func load_value(path: String, parse: bool = true):
	var file = FileAccess.open(path, FileAccess.READ)
	var value: String = file.get_pascal_string()
	if parse:
		var json: JSON = JSON.new()
		json.parse(value)
		return json.data
	else:
		return value
