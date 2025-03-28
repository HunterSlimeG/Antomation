extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_timer_timeout()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	add_child(BlackAnt.create("Spawner1", self.position))
	add_child(BlackAnt.create("Spawner2", $Node2D.position))
	#print(Globals.ants)
	$Timer.start()
