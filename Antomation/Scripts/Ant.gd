class_name Ant extends AnimatedSprite2D

var details


func death() -> void:
	Globals.ants.erase(self.name)
	queue_free()
	
func spawn() -> void:
	if not Globals.ants.has(self.name):
		pass
		#Globals.ants.set(self.name, )
	
