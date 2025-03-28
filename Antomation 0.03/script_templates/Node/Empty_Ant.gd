class_name AntName extends Ant

func _ready() -> void:
	stopPos = 30
	Speed = 100
	Health = 5
	Damage = 5
	species = "Genus Species"
	setAnims()
	super()
static func create(t : String, pos: Vector2):
	var new = load("res://Scenes/Ant.tscn").instantiate()
	new.Team = t
	new.position = pos
	return new
