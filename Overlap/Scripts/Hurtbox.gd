extends Area2D


const HIT_EFFECT = preload("res://Effects/Scenes/HitEffect.tscn")


# Declare member variables here. Examples:
export (bool) var show_hit = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Hurtbox_area_entered(area):
	if show_hit:
		var hit_effect_instance = HIT_EFFECT.instance()
		var world = get_tree().current_scene
		
		world.add_child(hit_effect_instance)
		hit_effect_instance.global_position = global_position
