extends Camera2D

var SPD = 5

func _process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
	if Input.is_action_just_pressed("CamSpd"):
		SPD = 15
	elif Input.is_action_just_released("CamSpd"):
		SPD = 5
	position += direction * SPD

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ZoomIn"):
		zoom += Vector2(.2, .2)
	elif event.is_action_pressed("ZoomOut"):
		zoom -= Vector2(.2, .2)
	zoom = zoom.clampf(0.5, 2)
