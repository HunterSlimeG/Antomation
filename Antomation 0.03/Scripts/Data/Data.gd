extends Node

var json = JSON.new()
var saves_path = "user://Saves/"
var ants_path = "user://Saves/Ants.json"

var data = {}

func save_data(content, path):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(json.stringify(content))
	file.close()
	
func load_data(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var content = json.parse_string(file.get_as_text())
	return content
	
func create_file():
	if not FileAccess.file_exists(saves_path):
		DirAccess.make_dir_absolute(saves_path)
		if not FileAccess.file_exists(ants_path):
			save_data({}, ants_path)
	
func _ready():
	create_file()
	data.version = Globals.ver
