extends KinematicBody2D


# Declare member constants here.
export (int) var  MAX_SPEED = 80		# It behavies like a constante
export (int) var  ACCELARATION = 500 	# It behavies like a constante
export (int) var  FRICTION = 500		# It behavies like a constante
export (int) var  ROLL_SPEED = 120		# It behavies like a constante

enum {
	MOVE,
	ROLL,
	ATTACK
}


# Declare member variables here. Examples:
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var state = MOVE
var stats = PlayerStats

onready var hurtbox = $Hurtbox
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")


# Called when the node enters the scene tree for the first time.
func _ready():
	stats.connect("no_health", self, "queue_free")
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match (state):
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)


func move_state(delta):
	var input_vector = Vector2.ZERO

	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELARATION * delta)
		
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		
		animationState.travel("Run")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
		animationState.travel("Idle")

	move()
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	if Input.is_action_just_pressed("roll"):
		state = ROLL


func move():
	velocity = move_and_slide(velocity)


func attack_state(delta):
	animationState.travel("Attack")


func roll_state(delta):
	velocity = roll_vector * ROLL_SPEED
	move()
	
	animationState.travel("Roll")


func attack_animation_finished():
	velocity = Vector2.ZERO
	state = MOVE


func roll_animation_finished():
	velocity *= .8
	state = MOVE


func _on_Hurtbox_area_entered(area):
	stats.health -= 1
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(.5)
