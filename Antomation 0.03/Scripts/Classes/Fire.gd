class_name FireAnt extends Ant

func _ready() -> void:
	stopPos = 50
	Speed = 175
	Health = 3
	Damage = 3
	species = "solenopsis invicta"
	setAnims()
	super()
static func create(t : String, pos: Vector2):
	var new = load("res://Scenes/FireAnt.tscn").instantiate()
	new.Team = t
	new.position = pos
	return new
