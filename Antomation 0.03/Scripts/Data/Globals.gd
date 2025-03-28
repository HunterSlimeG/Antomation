extends Node

var ver = 0.01
var ants: Dictionary

func _ready() -> void:
	ants = Data.load_data(Data.ants_path)
