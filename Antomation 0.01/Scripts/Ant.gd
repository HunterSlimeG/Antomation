class_name Ant extends AnimatedSprite2D

@export var species : String

func death() -> void:
	Globals.ants.erase(self.name)
	queue_free()
	
func spawn() -> void:
	if not Globals.ants.has(self.name):
		Globals.ants.set(self.name, self)
	
