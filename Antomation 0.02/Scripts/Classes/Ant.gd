class_name Ant extends CharacterBody2D

var animationlib = {
	"monomorium minimum" : ["black_move", "black_attack", "black_idle", "black_collect"],
	"solenopsis invicta" : ["fire_move", "fire_attack", "fire_idle", "fire_collect"],
	"acromyrmex octospinosus" : ["leafcutter_move", "leafcutter_attack", "leafcutter_idle", "leafcutter_collect"],
	}
var animations : Array
var Speed : float
var species : String
var moveVects = [Vector2(0, 50), Vector2(0, -50), Vector2(50, 0), Vector2(-50, 0), Vector2(50, 50), Vector2(-50, 50), Vector2(50, -50), Vector2(-50, -50)]
var moveVect = Vector2(0, 0)
var stopPos : float

var Damage : float
var Health : float
var moveable = true
var attackTargets = []
var attackTarget = null
var scanTargets = []
var scanTarget = null

#Node
func _ready() -> void:
	spawn()
	$Hitbox.value = Damage
	$Idle.timeout.connect(idle)
	$Move.timeout.connect(moveRandom)
	$Sprite.frame_changed.connect(frameChange)
	$AttackArea.body_entered.connect(attackEnter)
	$AttackArea.body_exited.connect(attackExit)
	$ScanArea.body_entered.connect(scanEnter)
	$ScanArea.body_exited.connect(scanExit)
	idleStart()
	moveRandom()
func _process(delta: float) -> void:
	#print(self.name+":"+str(Health))
	if Health<=0:
		death()
	if $Sprite.is_playing() and !$Sprite.animation.contains("move"):
		moveable = false
	else:
		moveable = true
	if !attackTargets.is_empty():
		for attackT in attackTargets:
			if attackTarget == null:
				attackTarget = attackT
			elif position.distance_to(attackT.position)<position.distance_to(attackTarget.position):
				attackTarget = attackT
	else:
		attackTarget = null
	if !scanTargets.is_empty():
		for scanT in scanTargets:
			if scanTarget == null:
				scanTarget = scanT
			elif position.distance_to(scanT.position)<position.distance_to(scanTarget.position):
					scanTarget = scanT
	else:
		scanTarget = null
		
	if attackTarget != null and !$Sprite.is_playing():
		attack()
func _physics_process(delta: float) -> void:
	if scanTarget != null:
		moveTo(scanTarget.position, delta)
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		moveTo(get_global_mouse_position(), delta)
	else:
		moveBy(moveVect, delta)

#Animation
func frameChange() -> void:
	if $Sprite.animation.contains("attack"):
		if species=="monomorium minimum":
			if $Sprite.frame>=3 and $Sprite.frame<=4:
				$Hitbox/CollisionShape2D.disabled = false
			else:
				$Hitbox/CollisionShape2D.disabled = true
		elif species=="solenopsis invicta":
			if $Sprite.frame>=4 and $Sprite.frame<=5:
				$Hitbox/CollisionShape2D.disabled = false
			else:
				$Hitbox/CollisionShape2D.disabled = true
		elif species=="acromyrmex octospinosus":
			if $Sprite.frame>=3 and $Sprite.frame<=4:
				$Hitbox/CollisionShape2D.disabled = false
			else:
				$Hitbox/CollisionShape2D.disabled = true
func setAnims() -> void:
	$Sprite.sprite_frames = load("res://Resources/Sprites/AntAnims.tres")
	animations = animationlib[species]

#Global
func death() -> void:
	Globals.ants.erase(self.name)
	queue_free()
	
func spawn() -> void:
	if not Globals.ants.has(self.name):
		Globals.ants.set(self.name, self)

#Movement
func moveTo(pos, d):
	var dir = position.direction_to(pos)*Speed
	if moveable:
		if abs(position.distance_to(pos))>stopPos:
			velocity = dir*d
			if dir.x>0.1:
				$Sprite.flip_h = false
				$Hitbox.scale.x = 1
				$AttackArea.scale.x = 1
			elif dir.x<0.1:
				$Sprite.flip_h = true
				$Hitbox.scale.x = -1
				$AttackArea.scale.x = -1
		else:
			velocity = Vector2.ZERO
		move_and_collide(velocity)
		if velocity!=Vector2.ZERO and !$Sprite.is_playing():
			$Sprite.play(animations[0])
		elif velocity==Vector2.ZERO:
			$Sprite.stop()
		idleStart()
func moveBy(dir, d):
	dir*Speed
	if moveable:
		velocity = dir*d
		if dir.x>0.1:
			$Sprite.flip_h = false
			$Hitbox.scale.x = 1
			$AttackArea.scale.x = 1
		elif dir.x<0.1:
			$Sprite.flip_h = true
			$Hitbox.scale.x = -1
			$AttackArea.scale.x = -1
		move_and_collide(velocity)
		if dir!=Vector2.ZERO and !$Sprite.is_playing():
			$Sprite.play(animations[0])
		elif velocity==Vector2.ZERO:
			$Sprite.stop()
		idleStart()
func moveRandom():
	var wait = RandomNumberGenerator.new()
	$Move.start(wait.randf_range(1.0, 5.0))
	if wait.randi_range(1, 3)>1:
		moveVect = moveVects.pick_random()
	else:
		moveVect = Vector2(0, 0)

#Actions
func collect():
	$Sprite.play(animations[3])
	idleStart()
func attack():
	$Sprite.play(animations[1])
	idleStart()
func attackEnter(body):
	if body != self:
		attackTargets.append(body)
func attackExit(body):
	attackTargets.erase(body)
func scanEnter(body):
	if body != self:
		scanTargets.append(body)
func scanExit(body):
	scanTargets.erase(body)
func idle():
	$Sprite.play(animations[2])
	idleStart()
func idleStart():
	moveable = false
	var wait = RandomNumberGenerator.new()
	$Idle.start(wait.randf_range(1.0, 5.0))
	

#Values
func damage(val):
	Health -= val
