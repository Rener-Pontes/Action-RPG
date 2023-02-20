extends KinematicBody2D


# Declare member constants here.
const MAX_VELOCITY = 100


# Declare member variables here. Examples:
var velocity:Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var input_vector:Vector2

	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(MAX_VELOCITY * input_vector, 25.0)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, 25)

	velocity = move_and_slide(velocity)
	pass
