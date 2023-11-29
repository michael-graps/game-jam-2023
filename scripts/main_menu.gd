extends Control

func _ready():
	$play_button.grab_focus()
	PlayerCollectionsTracker.resetcollections()
	
	$menu_bg_animated.play()
	Engine.max_fps = 60


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/intro_cutscene.tscn")


func _on_quickstart_button_pressed():
	get_tree().change_scene_to_file("res://scenes/area1_basement.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
