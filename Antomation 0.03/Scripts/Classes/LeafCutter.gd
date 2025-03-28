class_name LeafCutterAnt extends Ant

func _ready() -> void:
	stopPos = 100
	Speed = 75
	Health = 25
	Damage = 3
	species = "acromyrmex octospinosus"
	setAnims()
	super()
static func create(t : String, pos: Vector2):
	var new = load("res://Scenes/LeafCutterAnt.tscn").instantiate()
	new.Team = t
	new.position = pos
	return new
