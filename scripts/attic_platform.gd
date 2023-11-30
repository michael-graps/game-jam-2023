extends Node2D

@onready var cbody = $StaticBody2D/platform_collision

func _ready():
	hide()

func _physics_process(delta):
	cbody.disabled = true
	if PlayerCollectionsTracker.part1_got >= 1:
		show()
		cbody.disabled = false
