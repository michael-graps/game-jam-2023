extends Node2D

func _ready():
	$end_animation.play()
	$menu_button.grab_focus()


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_replay_button_pressed():
	get_tree().change_scene_to_file("res://scenes/intro_cutscene.tscn")
	PlayerCollectionsTracker.resetcollections()
	PlayerPositionManager.reset_position()
