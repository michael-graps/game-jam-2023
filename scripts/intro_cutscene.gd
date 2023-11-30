extends Node2D

@onready var pt1 = $Page1/AnimationPlayer
@onready var pt2 = $Page2/AnimationPlayer
@onready var pt3 = $Page3/AnimationPlayer
@onready var pt4 = $Page4/AnimationPlayer
@onready var pt5 = $Page5/AnimationPlayer
@onready var pt6 = $Page6/AnimationPlayer
@onready var pt7 = $Page7/AnimationPlayer
@onready var fade = $Camera2D/ColorRect/fade_in

var PageNum = 0 

func _ready():
	$Page1.hide()
	$Page2.hide()
	$Page3.hide()
	$Page4.hide()
	$Page5.hide()
	$Page6.hide()
	$Page7.hide()
	$Timer.start()
	$TransitionTimer.start()
	fade.play("fade_into_intro")
	pass

func _physics_process(delta):
	
	#print(str(PageNum))
	
	if PageNum == 0:
		$Page1.show()
		pt1.play("page_1")
		PageNum = PageNum + 1
		$Timer.start()
	
	elif PageNum == 1 and $Timer.time_left == 0:
		$Page2.show()
		pt2.play("page_2")
		PageNum = PageNum + 1
		$Timer.start()
	
	elif PageNum == 2 and $Timer.time_left == 0:
		$Page3.show()
		pt3.play("page_3")
		PageNum = PageNum + 1
		$Timer.start()
	
	elif PageNum == 3 and $Timer.time_left == 0:
		$Page4.show()
		pt4.play("page_4")
		PageNum = PageNum + 1
		$Timer.start()
	
	elif PageNum == 4 and $Timer.time_left == 0:
		$Page5.show()
		pt5.play("page_5")
		PageNum = PageNum + 1
		$Timer.start()
	
	elif PageNum == 5 and $Timer.time_left == 0:
		$Page6.show()
		pt6.play("page_6")
		PageNum = PageNum + 1
		$Timer.start()
	
	elif PageNum == 6 and $Timer.time_left == 0:
		$Page7.show()
		pt7.play("page_7")
		PageNum = PageNum + 1
		fade.play("fade_out")
		$Timer.start()

	else:
		if PageNum == 7 and $Timer.time_left == 0 and $TransitionTimer.time_left == 0:
			print("Transitioning from the Intro to Area 1")
			get_tree().change_scene_to_file("res://scenes/area1_basement.tscn")
