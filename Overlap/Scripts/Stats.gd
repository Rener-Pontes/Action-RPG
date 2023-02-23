extends Node


# Declare member variables here. Examples:
export (int) var max_health = 1
onready var health = max_health setget set_health


signal no_health


func set_health(value):
	health = value
	
	if health <= 0:
		emit_signal("no_health")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
