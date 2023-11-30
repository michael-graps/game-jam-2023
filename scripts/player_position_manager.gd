extends Node

# I MADE A MISTAKE NAMING THIS BUT I'M TOO FAR GONE TO FIX IT ¯\_(ツ)_/¯  #
# The variable is called 'prev_area', but you use it to tell the player   #
# controller where the player should be teleported to. Think of it more   #
# like "where do I want to be sent to" and less "where was I coming from" #

# For the 'prev_area' variable;
# 1 = Basement Start
# 2 = Kitchen Bottom Left
# 3 = Attic
# 4 = Basement End
# 5 = Basement Top
# 6 = Kitchen Top Right

var prev_area = 0
var area2_entered = 1


func set_prev_area(area):
	if area == 1:
		prev_area = 1
	if area == 2:
		prev_area = 2
	if area == 3:
		prev_area = 3
	if area == 4:
		prev_area = 4
	if area == 5:
		prev_area = 5
	if area == 6:
		prev_area = 6
	else:
		pass

func reset_position():
	prev_area = 1
	area2_entered = 0

func entered_kitchen_first_time():
	area2_entered = 1
