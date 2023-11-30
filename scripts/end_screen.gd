extends Node2D

@export var event: EventAsset
@export var music: EventAsset
var instance: EventInstance
var stop_music = 1
var soundbuffer = 1

func _ready():
	$end_animation.play()
	$menu_button.grab_focus()
	PlayerCollectionsTracker.set_game_completed()
	instance = FMODRuntime.create_instance(music)
	instance.start()


func _on_menu_button_pressed():
	instance.set_parameter_by_name("stop_music", stop_music, false)
	Events.change_scene.emit("res://scenes/main_menu.tscn")

func _on_menu_button_focus_entered():
	if soundbuffer == 1:
		soundbuffer = 0
		pass
	else:
		FMODRuntime.play_one_shot(event)


func _on_replay_button_pressed():
	PlayerCollectionsTracker.resetcollections()
	PlayerPositionManager.reset_position()
	instance.set_parameter_by_name("stop_music", stop_music, false)
	Events.change_scene.emit("res://scenes/intro_cutscene.tscn")
	
func _on_replay_button_focus_entered():
	FMODRuntime.play_one_shot(event)


