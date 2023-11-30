extends Control

@export var event: EventAsset
@export var music: EventAsset
var instance: EventInstance
var stop_music = 1.0

var soundbuffer = 1

func _ready():
	$logo_smol.hide()
	$play_button.grab_focus()
	PlayerCollectionsTracker.resetcollections()
	PlayerPositionManager.reset_position()
	$menu_bg_animated.play()
	instance = FMODRuntime.create_instance(music)
	instance.start()
	if PlayerCollectionsTracker.game_completed == 0:
		$logo_nosmol.show()
	if PlayerCollectionsTracker.game_completed == 1:
		$logo_nosmol.hide()
		$logo_smol.show()
	Engine.max_fps = 60


func _on_play_button_pressed():
	instance.set_parameter_by_name("stop_music", stop_music, false)
	get_tree().change_scene_to_file("res://scenes/intro_cutscene.tscn")

func _on_play_button_focus_entered():
	if soundbuffer == 1:
		soundbuffer = 0
		pass
	else:
		FMODRuntime.play_one_shot(event)


func _on_quickstart_button_pressed():
	instance.set_parameter_by_name("stop_music", stop_music, false)
	get_tree().change_scene_to_file("res://scenes/area1_basement.tscn")

func _on_quickstart_button_focus_entered():
	FMODRuntime.play_one_shot(event)


func _on_quit_button_pressed():
	get_tree().quit()

func _on_quit_button_focus_entered():
	FMODRuntime.play_one_shot(event)
