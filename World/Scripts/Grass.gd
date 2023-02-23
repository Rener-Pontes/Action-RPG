extends Node2D


const GRASS_EFFECT = preload("res://Effects/Scenes/GrassEffect.tscn")


func create_grass_effect():
	var grassEffectInstance = GRASS_EFFECT.instance()
	
	get_parent().add_child(grassEffectInstance)
	grassEffectInstance.global_position = global_position


func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
