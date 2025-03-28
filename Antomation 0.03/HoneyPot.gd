class_name HoneyPotAnt extends Ant

var storeStage = 0
var storeVal = 0
func _ready() -> void:
	stopPos = 100
	Speed = 50
	Health = 50
	Damage = 0
	species = "myrmecocystus mexicanus"
	setAnims()
	super()
func _process(delta: float) -> void:
	super(delta)
	foodCheck(delta)
	
	
func foodCheck(d):
	if storeVal==0:
		storeStage = 0
		Speed = 50
	elif storeVal<=5:
		storeStage = 1
		Speed = 25
	elif storeVal<=10:
		storeStage = 2
		Speed = 10
	elif storeVal<=15:
		storeStage = 3
		Speed = 0
func addFood(val):
	if storeStage<3 and storeVal<15:
		storeVal += val
static func create(t : String, pos: Vector2):
	var new = load("res://Scenes/Ant.tscn").instantiate()
	new.Team = t
	new.position = pos
	return new
