class_name Player
extends CharacterBody2D

const ANIMATION_STATES: PackedStringArray = [
	"Idle",
	"Run",
]

@export_group("Motion")
@export var max_speed: int
@export var acceleration: int
@export var friction: int

@onready var _animation_tree := $AnimationTree as AnimationTree
@onready var _playback := $AnimationTree["parameters/playback"] as AnimationNodeStateMachinePlayback


func _ready() -> void:
	_animation_tree.active = true
	pass


func _physics_process(delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("Left", "Right", "Up", "Down").normalized()

	if input_dir != Vector2.ZERO:
		velocity = velocity.move_toward(input_dir * max_speed, acceleration * delta)
		_set_anim_blend_pos(input_dir)
		_playback.travel(ANIMATION_STATES[1])
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		_playback.travel(ANIMATION_STATES[0])

	move_and_slide()


func _set_anim_blend_pos(_dir: Vector2) -> void:
	for anim_state in ANIMATION_STATES:
		var path: String = "parameters/%s/blend_position" % anim_state
		_animation_tree.set_deferred(path, _dir)
