class_name Hitbox
extends Area2D

@export var value := 5
@export_enum("Damage:1") var type : int = 1
func _init():
	monitoring = false
	collision_layer = 2
	collision_mask = 0
