extends Node2D


# Declare member variables here. Examples:
onready var animatedSprite = $AnimatedSprite 


# Called when the node enters the scene tree for the first time.
func _ready():
	animatedSprite.frame = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	queue_free()
