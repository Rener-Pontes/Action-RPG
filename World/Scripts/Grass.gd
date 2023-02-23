extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # Replace with function body.

func create_grass_effect():
	var grassEffect = load("res://Effects/Scenes/GrassEffect.tscn")
	var grassEffectInstance = grassEffect.instance()
	var world = get_tree().current_scene  
	
	world.add_child(grassEffectInstance)
	grassEffectInstance.global_position = global_position

func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()