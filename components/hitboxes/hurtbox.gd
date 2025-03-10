@tool
class_name Hurtbox
extends Area2D

signal hit(damage: int)

const DEBUG_COLOR: Color = Color(0.6, 0.3, 0.3, 0.5)


func _ready() -> void:
	area_entered.connect(_on_hitbox_collision)

	if Engine.is_editor_hint():
		_update_debug_color()


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		return

	_update_debug_color()


func _on_hitbox_collision(hitbox: Hitbox) -> void:
	hit.emit(hitbox.hit_damage)


func _update_debug_color() -> void:
	var shape := get_node_or_null("CollisionShape2D") as CollisionShape2D

	if not shape:
		return

	shape.debug_color = DEBUG_COLOR
