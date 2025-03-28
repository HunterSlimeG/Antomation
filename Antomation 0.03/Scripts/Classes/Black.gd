class_name BlackAnt extends Ant

func _ready() -> void:
	stopPos = 30
	Speed = 100
	Health = 5
	Damage = 5
	species = "monomorium minimum"
	setAnims()
	super()
static func create(t : String = "World", pos: Vector2 = Vector2(0,0)):
	var new = load("res://Scenes/BlackAnt.tscn").instantiate()
	new.Team = t
	new.position = pos
	return new
