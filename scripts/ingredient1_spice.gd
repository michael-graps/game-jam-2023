extends Node2D

@export var event: EventAsset

func _ready():
	if PlayerCollectionsTracker.part1_got == 1:
		queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
			queue_free()
			FMODRuntime.play_one_shot(event)
			PlayerCollectionsTracker.part1gotten()
