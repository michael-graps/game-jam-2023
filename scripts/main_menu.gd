extends Control

func _ready():
	$VBoxContainer/IntroStart.grab_focus()
	Engine.max_fps = 60

func _on_intro_start_pressed():
	get_tree().change_scene_to_file("res://scenes/intro_cutscene.tscn")

func _on_quick_start_pressed():
	get_tree().change_scene_to_file("res://scenes/area1_basement.tscn")

func _on_options_button_pressed():
	print("THIS BUTTON DOESN'T FUCKIN' DO ANYTHING RIGHT NOW, FUCK OFF")

func _on_quit_button_pressed():
	get_tree().quit()
