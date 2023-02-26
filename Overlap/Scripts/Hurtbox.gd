extends Area2D


const HIT_EFFECT = preload("res://Effects/Scenes/HitEffect.tscn")


# Declare member variables here. Examples:
var invincible = false setget set_invincible

onready var timer = $Timer
onready var collisionShape = $CollisionShape2D


signal invincibility_started
signal invincibility_ended


func set_invincible(value):
	invincible = value
	
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")


func create_hit_effect():
	var hit_effect_instance = HIT_EFFECT.instance()
	var world = get_tree().current_scene
	
	world.add_child(hit_effect_instance)
	hit_effect_instance.global_position = global_position


func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)


func _on_Timer_timeout():
	self.invincible = false


func _on_Hurtbox_invincibility_started():
	collisionShape.set_deferred("disabled", true)


func _on_Hurtbox_invincibility_ended():
	collisionShape.set_deferred("disabled", false)
