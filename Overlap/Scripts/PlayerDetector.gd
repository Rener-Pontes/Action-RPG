extends Area2D


# Declare member variables here. Examples:
var player = null


func can_see_player():
	return player != null


func _on_PlayerDetector_body_entered(body):
	player = body


func _on_PlayerDetector_body_exited(_body):
	player = null
