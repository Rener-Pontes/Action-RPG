extends KinematicBody2D


# Declare member constants here.
const MAX_SPEED:int = 100
const ACCELARATION:int = 500 
const FRICTION:int = 500


# Declare member variables here. Examples:
var velocity:Vector2 = Vector2.ZERO

onready var animationPlayer:AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_vector:Vector2

	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELARATION * delta)
		if input_vector.y < 0:
			animationPlayer.play("RunUp")
		else:
			animationPlayer.play("RunDown")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		animationPlayer.play("IdleDown")

	velocity = move_and_slide(velocity)
