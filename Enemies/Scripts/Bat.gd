extends KinematicBody2D


# Declare member variables here. Examples:
var knockback = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	
	move_and_slide(knockback)


func _on_Hurtbox_area_entered(area):
	knockback = area.knockback_vector * 120
