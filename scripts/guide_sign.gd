extends Node2D

@export var Point_Left = false
@export var Point_Right = true
@export var Point_Up = false

func _ready():
	if PlayerCollectionsTracker.everything_got == 0:
		self.hide()
	$side.hide()
	$up.hide()
	if Point_Left == true:
		$side.flip_h = true
		$side.show()
	if Point_Right == true:
		$side.flip_h = false
		$side.show()
	if Point_Up == true:
		$up.show()
