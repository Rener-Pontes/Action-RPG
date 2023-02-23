extends KinematicBody2D


const DEATH_EFFECT = preload("res://Effects/Scenes/EnemyDeathEffect.tscn")


# Declare member variables here. Examples:
var knockback = Vector2.ZERO

onready var stats = $Stats


# Called when the node enters the scene tree for the first time.
func _ready():
	stats.connect("no_health", self, "_on_no_health")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	
	knockback = move_and_slide(knockback)


func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 120

func _on_no_health():
	var deathEffectInstance = DEATH_EFFECT.instance()
	
	get_parent().add_child(deathEffectInstance)
	deathEffectInstance.global_position = global_position
	
	queue_free()
