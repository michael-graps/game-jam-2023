extends Control

@export var event: EventAsset
var soundbuffer = 1

func _process(delta):
	hide_stuff()
	show_stuff()
	if Input.is_action_just_pressed("pause_button"):
		$resume_button.grab_focus()

func show_stuff():
	if PlayerCollectionsTracker.list_got == 1:
		$ingredients_list.show()
	if PlayerCollectionsTracker.part1_got == 1:
		$ingredients_list/check1.show()
	if PlayerCollectionsTracker.part2_got == 1:
		$ingredients_list/check2.show()
	if PlayerCollectionsTracker.part3_got == 1:
		$ingredients_list/check3.show()

func hide_stuff():
	if PlayerCollectionsTracker.list_got == 0:
		$ingredients_list.hide()
	if PlayerCollectionsTracker.part1_got == 0:
		$ingredients_list/check1.hide()
	if PlayerCollectionsTracker.part2_got == 0:
		$ingredients_list/check2.hide()
	if PlayerCollectionsTracker.part3_got == 0:
		$ingredients_list/check3.hide()


func _on_quit_button_pressed():
	get_tree().quit()


func _on_resume_button_pressed():
	Input.action_press("pause_button")
	Input.action_release("pause_button")
	
func _on_quit_button_focus_entered():
	FMODRuntime.play_one_shot(event)
	
	
func _on_resume_button_focus_entered():
	if soundbuffer == 1:
		soundbuffer = 0
		pass
	else:
		FMODRuntime.play_one_shot(event)




