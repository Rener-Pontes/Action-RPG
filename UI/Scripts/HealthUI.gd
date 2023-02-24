extends Control


# Declare member variables here. Examples:
var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts

onready var emptyHeartUI = $EmptyHeartUI
onready var fullHeartUI = $FullHeartUI


func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	
	if fullHeartUI != null:
		fullHeartUI.rect_size.x = hearts * 15


func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if emptyHeartUI != null:
		emptyHeartUI.rect_size.x = hearts * 15


func _ready():
	PlayerStats.connect("health_changed", self, "set_hearts")
	PlayerStats.connect("max_health_changed", self, "set_max_hearts")
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
