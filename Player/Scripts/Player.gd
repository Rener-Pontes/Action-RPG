extends KinematicBody2D


# Declare member constants here.
const MAX_SPEED = 100
const ACCELARATION = 500 
const FRICTION = 500


enum {
	MOVE,
	ROLL,
	ATTACK
}


# Declare member variables here. Examples:
var velocity = Vector2.ZERO
var state = MOVE

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")


# Called when the node enters the scene tree for the first time.
func _ready():
	animationTree.active = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match (state):
		MOVE:
			move_state(delta)
		ROLL:
			pass
		ATTACK:
			attack_state(delta)


func move_state(delta):
	var input_vector = Vector2.ZERO

	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELARATION * delta)
		
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		
		animationState.travel("Run")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
		animationState.travel("Idle")

	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attack_state(delta):
	animationState.travel("Attack")

func attack_animation_finished():
	velocity = Vector2.ZERO
	state = MOVE
