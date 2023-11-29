extends Node

var list_got = 0
var part1_got = 0
var part2_got = 0
var part3_got = 0
var everything_got = 0

func resetcollections():
	list_got = 0
	part1_got = 0
	part2_got = 0
	part3_got = 0
	everything_got = 0

func listgotten():
	list_got = 1

func part1gotten():
	part1_got = 1

func part2gotten():
	part2_got = 1

func part3gotten():
	part3_got = 1

func allgotten_check():
	if list_got == 1 and part1_got == 1 and part2_got == 1 and part3_got == 1:
		everything_got = 1
	else:
		pass
