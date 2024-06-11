extends Object

class_name Encrypter

static var code: Dictionary = {
	"a": 101,
	"b": 102,
	"c": 103,
	"d": 104,
	"e": 105,
	"f": 106,
	"g": 107,
	"h": 108,
	"i": 109,
	"j": 10,
	"k": 11,
	"l": 12,
	"m": 13,
	"n": 14,
	"o": 15,
	"p": 16,
	"q": 17,
	"r": 18,
	"s": 19,
	"t": 20,
	"u": 21,
	"v": 22,
	"w": 23,
	"x": 24,
	"y": 25,
	"z": 26,
	"[": 27,
	"]": 28,
	",": 29,
	".": 30,
	"{": 31,
	"}": 32,
	"1": 201,
	"2": 202,
	"3": 203,
	"4": 204,
	"5": 205,
	"6": 206,
	"7": 207,
	"8": 208,
	"9": 209,
	"0": 200,
	" ": 33,
	'"': 34,
	"'": 35,
}

static func encode(value):
	var encoded_value = []
	for character in JSON.stringify(value):
		if not character == "":
			encoded_value.append("".join([str(code[character]),"|"]))
	encoded_value = "".join(encoded_value)
	return encoded_value

static func decode(value: String):
	var decoded_value = []
	var characters = []
	var temp_array = []
	for character in value:
		if not character == "":
			if character == "|":
				characters.append(int("".join(temp_array)))
				temp_array = []
			else:
				temp_array.append(character)
	for encoded_character in characters:
		decoded_value.append(code.find_key(encoded_character))
	decoded_value = "".join(decoded_value)
	return JSON.parse_string(decoded_value)

