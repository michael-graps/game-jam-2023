extends Node2D

@export var event: EventAsset
@onready var ap = $Sparkle

func _ready():
	ap.play("sparkle")
	if PlayerCollectionsTracker.part1_got == 1:
		queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
			queue_free()
			FMODRuntime.play_one_shot(event)
			PlayerCollectionsTracker.part1gotten()
