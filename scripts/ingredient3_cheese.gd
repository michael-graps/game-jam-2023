extends Node2D

@export var event: EventAsset
@onready var ap = $Sparkle
var playedsound = 0
var timer_started = 0

func _ready():
	ap.play("sparkle")
	if PlayerCollectionsTracker.part3_got == 1:
		queue_free()

func _physics_process(delta):
	if PlayerCollectionsTracker.part3_got == 1 and playedsound == 0:
		FMODRuntime.play_one_shot(event)
		self.hide()
		if timer_started == 0:
			$music_timer.start()
			timer_started = 1
		playedsound = 1
	if $music_timer.time_left == 0 and playedsound == 1:
		InteractionManager.cheesefinish = 1
		queue_free()
