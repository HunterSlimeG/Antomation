class_name ArmyAnt extends Ant

func _ready() -> void:
	stopPos = 40
	Speed = 100
	Health = 10
	Damage = 8
	species = "eciton burchellii"
	setAnims()
	super()
static func create(t : String, pos: Vector2):
	var new = load("res://Scenes/ArmyAnt.tscn").instantiate()
	new.Team = t
	new.position = pos
	return new
