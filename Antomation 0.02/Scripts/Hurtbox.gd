class_name Hurtbox
extends Area2D
var collide = false
var target : Hitbox
var cooldown = true

func _init():
	collision_layer = 0
	collision_mask = 2
	
	
	
func _ready():
	connect("area_entered", self._on_area_entered)
	
	
func _process(delta: float) -> void:
	if collide && cooldown:
		cooldown = false
		if target == null:
			return
		if target.type == 1 and target.owner!=self.owner:
			if owner.has_method("damage"):
				owner.damage(target.value)
	
func _on_area_entered(hitbox: Hitbox):
	collide = true
	cooldown = true
	target = hitbox

func _on_area_exited(hitbox: Hitbox):
	collide = false
	cooldown = false


func _on_timer_timeout() -> void:
	cooldown = true
