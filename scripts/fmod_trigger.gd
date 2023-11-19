extends Node

class_name FmodTrigger

@export var event: EventAsset

func walk_sound_trigger():
	FMODRuntime.play_one_shot(event)
