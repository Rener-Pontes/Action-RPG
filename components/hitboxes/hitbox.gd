@tool
class_name Hitbox
extends Area2D

@export var hit_damage: int

const DEBUG_COLOR: Color = Color(0.4, 0.6, 0.5, 0.5)


func _ready() -> void:
	if Engine.is_editor_hint():
		_update_debug_color()


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		return

	_update_debug_color()


func _update_debug_color() -> void:
	var shape := get_node_or_null("CollisionShape2D") as CollisionShape2D
	if not shape:
		return

	shape.debug_color = DEBUG_COLOR
