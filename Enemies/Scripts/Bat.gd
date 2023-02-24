extends KinematicBody2D


export (int) var MAX_SPEED = 50
export (int) var ACCELARATION = 300
export (int) var FRICTION = 200

const DEATH_EFFECT = preload("res://Effects/Scenes/EnemyDeathEffect.tscn")

enum {
	IDLE,
	WANDER,
	CHASE
}


# Declare member variables here. Examples:
var knockback = Vector2.ZERO
var velocity = Vector2.ZERO
var state = IDLE

onready var stats = $Stats
onready var playerDetector = $PlayerDetector
onready var animatedSprite = $AnimatedSprite
onready var hurtbox = $Hurtbox


# Called when the node enters the scene tree for the first time.
func _ready():
	stats.connect("no_health", self, "_on_no_health")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	
	match(state):
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = playerDetector.player
			
			if player != null:
				var target = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(target * MAX_SPEED, ACCELARATION * delta)
			else:
				state = IDLE
	
	animatedSprite.flip_h = velocity.x < 0
	
	knockback = move_and_slide(knockback)
	velocity = move_and_slide(velocity)


func seek_player():
	if playerDetector.can_see_player():
		state = CHASE


func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.create_hit_effect()
	knockback = area.knockback_vector * 120


func _on_no_health():
	var deathEffectInstance = DEATH_EFFECT.instance()
	
	get_parent().add_child(deathEffectInstance)
	deathEffectInstance.global_position = global_position
	
	queue_free()
