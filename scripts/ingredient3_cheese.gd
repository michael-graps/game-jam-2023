extends Node2D

@export var event: EventAsset
@onready var ap = $Sparkle
var playedsound = 0

func _ready():
	ap.play("sparkle")
	if PlayerCollectionsTracker.part3_got == 1:
		queue_free()

func _physics_process(delta):
	if PlayerCollectionsTracker.part3_got == 1 and playedsound == 0:
		FMODRuntime.play_one_shot(event)
		queue_free()
		playedsound = 1
