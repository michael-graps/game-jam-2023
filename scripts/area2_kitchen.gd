extends Node2D

@onready var candle_ap = $candle_light/candle_player
@onready var candle_ap2 = $candle_light2/candle_player
@onready var candle_ap3 = $candle_light3/candle_player
@onready var candle_ap4 = $candle_light4/candle_player
@onready var candle_ap5 = $candle_light5/candle_player
@onready var candle_ap6 = $candle_light6/candle_player

func _on_area_1_transition_body_entered(body):
	print("Teleporting to Area 1: The Basement")
	get_tree().change_scene_to_file("res://scenes/area1_basement.tscn")


func _on_area_3_transition_body_entered(body):
	print("Teleporting to Area 3: The Attic")
	get_tree().change_scene_to_file("res://scenes/area3_attic.tscn")

func _ready():
	Engine.max_fps = 60
	candle_ap.play("candle_light")
	candle_ap2.play("candle_light")
	candle_ap3.play("candle_light")
	candle_ap4.play("candle_light")
	candle_ap5.play("candle_light")
	candle_ap6.play("candle_light")

